# coding: utf-8

import sys
import re
import argparse

def signExtension(d, n):
	if int(d) >= 0:
		return format(int(d), 'b').zfill(n)
	else:
		return format((2 ** n) + int(d), 'b')



def typeADD(co, rd, rs):

	rs = format(int(rs), 'b').zfill(3)
	rd = format(int(rd), 'b').zfill(3)
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
		op3 = '0101'
	elif co == 'MOV':
		op3 = '0110'

	return '11' + rs + rd + op3 + d



def typeSLL(co, rd, d):
	
	rs = '000'
	rd = format(int(rd), 'b').zfill(3)
	d = signExtension(d, 4)

	if co == 'SLL':
		op3 = '1000'
	elif co == 'SLR':
		op3 = '1001'
	elif co == 'SRL':
		op3 = '1010'
	elif co == 'SRA':
		op3 = '1011'
	
	return '11' + rs + rd + op3 + d



def typeLD(co, ra, d, rb):

	ra = format(int(ra), 'b').zfill(3)
	rb = format(int(rb), 'b').zfill(3)
	d = signExtension(d, 8)

	if co == 'LD':
		op1 = '00'
	else:
		op1 = '01'

	return op1 + ra + rb + d



def typeLI(co, rb, d):

	rb = format(int(rb), 'b').zfill(3)
	d = signExtension(d, 8)

	return '10000' + rb + d



def typeB(co, rb, d):

	d = signExtension(d, 8)

	return '10100000' + d



def typeBE(co, d):

	d = signExtension(d, 8)

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
	num = 0
	flag = True

	for line in f:

		num += 1

		if line.isspace():
			print(str(num) + ' : Empty Line')
			continue

		line = line.strip()
	
		if line.startswith('#'):
			print(str(num) + ' : Comment')
			continue
	

		pat = re.compile('(ADD|SUB|AND|OR|XOR|CMP|MOV)\s+?[[][ \t]*?(\d+)[ \t]*?[]]\s+?[[][ \t]*?(\d+)[ \t]*?[]]')
		mat = pat.match(line)
		if mat:
			print (str(num) + ' : ' + mat.group(0))
			bit = typeADD(mat.group(1), mat.group(2), mat.group(3))
			machineCodes.append(bit)
			continue

		pat = re.compile('(SLL|SLR|SRL|SRA)\s+?[[][ \t]*?(\d+)[ \t]*?[]]\s+?(-??\d+)')
		mat = pat.match(line)
		if mat:
			print (str(num) + ' : ' + mat.group(0))
			bit = typeSLL(mat.group(1), mat.group(2), mat.group(3))
			machineCodes.append(bit)
			continue

		pat = re.compile('(LD|ST)\s+?[[][ \t]*?(\d+)[ \t]*?[]]\s+?(-??\d+)\([[][ \t]*?(\d+)[ \t]*?[]]\)')
		mat = pat.match(line)
		if mat:
			print (str(num) + ' : ' + mat.group(0))
			bit = typeLD(mat.group(1), mat.group(2), mat.group(3), mat.group(4))
			machineCodes.append(bit)
			continue;

		pat = re.compile('(LI)\s+?[[][ \t]*?(\d+)[ \t]*?[]]\s+?(-??\d+)')
		mat = pat.match(line)
		if mat:
			print (str(num) + ' : ' + mat.group(0))
			bit = typeLI(mat.group(1), mat.group(2), mat.group(3))
			machineCodes.append(bit)
			continue

		pat = re.compile('(B)\s+?[[][ \t]*?(\d+)[ \t]*?[]]\s+?(-??\d+)')
		mat = pat.match(line)
		if mat:
			print (str(num) + ' : ' + mat.group(0))
			bit = typeB(mat.group(1), mat.group(2), mat.group(3))
			machineCodes.append(bit)
			continue

		pat = re.compile('(BE|BLT|BLE|BNE)\s+?(-??\d+)')
		mat = pat.match(line)
		if mat:
			print (str(num) + ' : ' + mat.group(0))
			bit = typeBE(mat.group(1), mat.group(2))
			machineCodes.append(bit)
			continue

		flag = False
		
		break

	
	if flag:
		print('Success Assembling!!')
	else:
		print(str(num) + ' : Error! (line:' + str(num) + ')')
		machineCodes.append('Error')


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

