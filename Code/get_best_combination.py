import os

best_avg, best_name = 0, ""

names = {}
fout = file('covariance.csv', 'w')

count = 0
folder = "features_results"
for f in os.listdir(folder):
	#if (f.startswith('new_covariance.csv')):
	if (f.startswith('features') or f.startswith('covar')) and f.endswith('.csv'):
		print f
		for line in file(folder + os.sep + f):
			line = line.replace(';', ',')
			vals = line.strip().split(",")
			name, values = vals[0].strip(), vals[1:]

			if name.isdigit():
				name = "{ covar_%d }" % int(name)
			values = map(float, values)
			avg = sum(values) / float(len(values))
			if not name.endswith("}"): name = name + "}"
			
			if (name in names):
				pass
			else:
				names[name] = True
				count += 1
				
				print name, avg
				fout.write(name + "," + (','.join(map(str, values))) + '\n')
				
				if (avg > best_avg):
					best_avg = avg
					best_name = name
			
print "Best combination is %s with average %.2f" % (best_name, best_avg * 100)
print count, "results"

fout.close()
