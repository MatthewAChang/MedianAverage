.pos 0x100
				# main
start:			gpc $6, r6			# r6 = pc + 6
				j cal_avg			# goto cal_avg
				gpc $6, r6			# r6 = pc + 6
				j bubble_sort		# goto bubble_sort
				gpc $6, r6			# r6 = pc + 6
				j get_median		# goto get_median
				halt

.pos 0x200		
				# calculate average of students
cal_avg:		
				ld $n, r7			# r7 = &n
				ld (r7), r7			# r7 = n
				ld $s, r0			# r0 = &s
				ld (r0), r0			# r0 = s
				ld $24, r5			# r6 = 24
start_avg:
				bgt r7, avg			# goto avg if n > 0
				br end_avg			# goto end_avg
avg:
				ld $4, r3			# r3 = 4 = i
				ld $0, r2			# r2 = 0 = s
start_one_avg:		
				bgt r3, one_avg		# got one_avg if i > 0
				br end_one_avg		# got end_one
one_avg:			
				ld (r0, r3, 4), r1	# r1 = s->grade[i]
				add r1, r2			# s += grade[i]
				dec r3				# i--
				br start_one_avg	# goto start_one_avg
end_one_avg:		
				shr $2, r2			# s = s / 4
				st r2, 20(r0)		# avg = r2
				add r5, r0			# s += 24
				dec r7				# n--
				br start_avg		# goto start_avg
end_avg:		j (r6)
				
.pos 0x300		
				# sorts students by average
bubble_sort:	
				ld $n, r3			# r3 = &n
				ld (r3), r3			# r3 = n
				dec r3				# r3 = n - 1 = i
begin_outer:	
				ld $s, r0			# r0 = &s
				ld (r0), r0			# r0 = s
				ld $0, r4			# r4 = 0 = j
				bgt r3, begin_inner	# goto begin_inner if i > 0
				br end_outer		# goto end_outer`
begin_inner:	
				mov r4, r5			# r4 = r5 = j
				not r5
				inc r5				# r5 = -j
				add r3, r5			# r5 = i - j
				bgt r5, inner		# goto inner if i - j > 0
				br end_inner		# goto end_inner
inner:			
				ld 20(r0), r1		# r1 = s[i]->avg
				ld 44(r0), r2		# r2 = s[i + 1]->avg
				not r2
				inc r2				# r2 = -r2
				add r1, r2			# r2 = r2 + r1
				bgt r2, begin_swap	# goto begin_swap if r2 > r1
				ld $24, r5			# r5 = 24
				add r5, r0			# r0 += 24
				br end_swap			# goto end_swap

begin_swap:		
				ld $6, r7			# r7 = 6 = x
begin_swap_loop:
				bgt r7, swap		# goto swap if x > 0
				br end_swap			# goto end_swap
swap:			
				ld (r0), r1			# r1 = s
				ld 24(r0), r2		# r2 = s + 24
				st r2, (r0)			# s = r2
				st r1, 24(r0)		# s + 24 = r1
				dec r7				# r7--
				inca r0				# r0 += 4
				br begin_swap_loop	# goto begin_swap_loop
end_swap:
				inc r4				# j++
				br begin_inner		# goto begin_inner
end_inner:		
				dec r3				# i--
				br begin_outer		# goto begin_outer
end_outer:
				j (r6)				# goto main
				
.pos 0x400
				# stores the student's ID of the student with the median average
get_median:
				ld $s, r0			# r0 = &s
				ld (r0), r0			# r0 = s
				ld $n, r7			# r7 = &n
				ld (r7), r7			# r7 = n
				shr $1, r7			# r7 = n / 2
				ld $24, r1			# r1 = 24
begin_get_loop:	
				bgt r7, get_loop	# goto get_loop if n / 2 > 0
				br end_get_loop		# goto end_get_loop
get_loop:		
				add r1, r0			# s += 24
				dec r7				# n / 2 -= 1
				br begin_get_loop	# goto begin_get_loop
end_get_loop:	
				ld (r0), r2			# r2 = s->ID
				ld $m, r3			# r3 = &m
				st r2, (r3)			# m = s->IDs
				j(r6)				# goto main
				
.pos 0x1000
n:				.long 5				# number of students
m:				.long 0				# answer
s:				.long base			# address of the array
base:			.long 1234			# student ID
				.long 80			# grade 0
				.long 60			# grade 1
				.long 78			# grade 2
				.long 90			# grade 3
				.long 0				# avg
				.long 1111			# student ID
				.long 10			# grade 0
				.long 20			# grade 1
				.long 30			# grade 2
				.long 40			# grade 3
				.long 0				# avg
				.long 1000			# student ID
				.long 100			# grade 0
				.long 90			# grade 1
				.long 80			# grade 2
				.long 70			# grade 3
				.long 0				# avg
				.long 9000			# student ID
				.long 100			# grade 0
				.long 100			# grade 1
				.long 100			# grade 2
				.long 100			# grade 3
				.long 0				# avg
				.long 9999			# student ID
				.long 100			# grade 0
				.long 0				# grade 1
				.long 0				# grade 2
				.long 0				# grade 3
				.long 0				# avg