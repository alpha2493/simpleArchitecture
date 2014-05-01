# coding: utf-8

import sys
import re
import argparse

def signExtension(d,n):
	bit = format(int(d), 'b')

	if int(d) >= 0:
		return bit.zfill(n)
	else:
		length = len(bit)
		for i in range(n - length):
			bit = '1' + bit
		return bit



def typeADD(order):
	co = order[0]

	rs = format(int(order[2][1]), 'b').zfill(3)
	rd = format(int(order[1][1]), 'b').zfill(3)
	d = '0000'
	
	if co == 'ADD':
		op3 = '0000'
	elif co == 'SUB':
		op3 = '0001'
	elif co == 'AND':
		op3 = '0010'
	elif co == 'OR':
		op3 = '0011'
	elif co == 'XOR':
		op3 = '0100'
	elif co == 'CMP':
		op3 = '0110'
	elif co == 'MOV':
		op3 = '0000'

	return '11' + rs + rd + op3 + d



def typeSLL(order):
	co = order[0]
	
	rs = '000'
	rd = format(int(order[1][1]), 'b').zfill(3)
	d = format(int(order[2]), 'b').zfill(4)

	if co == 'SLL':
		op3 = '1000'
	elif co == 'SLR':
		op3 = '1001'
	elif co == 'SRL':
		op3 = '1010'
	elif co == 'SRA':
		op3 = '1011'
	
	return '11' + rs + rd + op3 + d



def typeLD(order):
	co = order[0]

	ra = format(int(order[1][1]), 'b').zfill(3)
	rb = format(int(order[2][3]), 'b').zfill(3)
	d = signExtension(order[2][0], 8)

	if co == 'LD':
		op1 = '00'
	else:
		op1 = '01'

	return op1 + ra + rb + d



def typeBE(order):
	co = order[0]

	d = signExtension(order[1], 8)

	if co == 'BE':
		cond = '000'
	elif co == 'BLT':
		cond = '001'
	elif co == 'BLE':
		cond = '010'
	elif co == 'BNE':
		cond = '011'

	return '10111' + cond + d



def assembler(f):
	machineCodes = []
	
	for line in f:
		if line[0] == '#':
			continue
		
		order = re.split(' |,|\t', line.rstrip('\n'))
		while order.count('') > 0:
			order.remove('')
		
		if len(order) == 0:
			continue

		c = order[0]

		if c == 'ADD' or c == 'SUB' or c == 'AND' or c == 'OR' or c == 'XOR' or c == 'CMP' or c == 'MOV':
			bit = typeADD(order)
		elif c == 'SLL' or c == 'SLR' or c == 'SRL' or c == 'SRA':
			bit = typeSLL(order)
		elif c == 'LD' or c == 'ST':
			bit = typeLD(order)
		elif c == 'LI':
			bit = '10000' + format(int(order[1][1]), 'b').zfill(3) + signExtension(order[2], 8)
		elif c == 'B':
			bit = '10100' + format(int(order[1][1]), 'b').zfill(3) + signExtension(order[2], 8)
		elif c == 'ADDI':
			bit = '10001' + format(int(order[1][1]), 'b').zfill(3) + signExtension(order[2], 8)
		elif c == 'BE' or c == 'BLT' or c == 'BLE' or c == 'BNE':
			bit = typeBE(order)
		else:
			continue

		machineCodes.append(bit)
	
	return machineCodes



def makeFile(rf, wf, width = 16, depth = 4096, start = 0):
	memos = """-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- Quartus II generated Memory Initialization File (.mif)

"""
	wf.write(memos)
	
	wf.write('WIDTH=' + str(width) + ';\n')
	wf.write('DEPTH=' + str(depth) + ';\n\n')
	wf.write('ADDRESS_RADIX=UNS;\n')
	wf.write('DATA_RADIX=BIN;\n\n')

	wf.write('CONTENT BEGIN\n')
	
	
	if start == 1:
		wf.write('\t0 : 0000000000000000;\n')
	elif start > 0:
		wf.write('\t[0..' + str(start - 1) + '] : 0000000000000000;\n')
		

	index = start
	codes = assembler(rf)
	
	for code in codes:
		wf.write('\t' + str(index) + ' : ' + code + ';\n')
		index += 1
	else:
		wf.write('\t[' + str(index) + '..' + str(depth - 1) + '] : 0000000000000000;\n')

	wf.write('END;\n')




if __name__ == '__main__':
	try:
		parser = argparse.ArgumentParser(description = 'Simple Assembler') #make cmd parser
		parser.add_argument('READ_FILE', help = 'input from <READ_FILE>' )
		parser.add_argument('-o', dest = 'WRITE_FILE', default = 'a.mif', help = 'output to <WRITE_FILE>')
		parser.add_argument('-w', dest = 'WIDTH', type = int, default = 16, help = 'memory\'s one word width')
		parser.add_argument('-d', dest = 'DEPTH', type = int, default = 4096, help = 'memory\'s word number')
		parser.add_argument('-s', dest = 'START', type = int, default = 0, help = 'position of initial instruction in memory')
		args = parser.parse_args()
		
		rf = open(args.READ_FILE, 'r')
		wf = open(args.WRITE_FILE, 'w')
	except IndexError:
		print('Invalid comand line argument\n')
	except IOError:
		print('Designated file cannot be opened\n')
	else:
		makeFile(rf, wf, args.WIDTH, args.DEPTH, args.START)
		rf.close()
		wf.close()
	finally:
		quit()

