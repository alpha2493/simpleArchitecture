# coding: utf-8

import sys
import re

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
	for line in f:
		order = re.split(' |,', line.rstrip('\n'))
		while order.count('') > 0:
			order.remove('')

		c = order[0]

		if c == 'ADD' or c == 'SUB' or c == 'AND' or c == 'OR' or c == 'XOR' or c == 'CMP' or c == 'MOV':
			bit = typeADD(order)
			print(bit)
		elif c == 'SLL' or c == 'SLR' or c == 'SRL' or c == 'SRA':
			bit = typeSLL(order)
			print(bit)
		elif c == 'LD' or c == 'ST':
			bit = typeLD(order)
			print(bit)
		elif c == 'LI':
			bit = '10000' + format(int(order[1][1]), 'b').zfill(3) + signExtension(order[2], 8)
			print(bit)
		elif c == 'B':
			bit = '10100' + format(int(order[1][1]), 'b').zfill(3) + signExtension(order[2], 8)
			print(bit)
		elif c == 'BE' or c == 'BLT' or c == 'BLE' or c == 'BNE':
			bit = typeBE(order)
			print(bit)



try:
	filename = sys.argv[1]
	f = open(filename, 'r')
except IndexError:
	print('Please input filename.')
except IOError:
	print('"%s" cannot be opened' % filename)
else:
	assembler(f)
	f.close()
finally:
	quit()
