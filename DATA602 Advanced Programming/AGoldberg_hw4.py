import csv

with open('brainandbody.csv', 'rb') as f:
    reader = csv.reader(f)
    brainbody = list(reader)

#convert data to integers
conversions = (str, float, float)
brainBodyConvert = [list(conv(v) for v, conv in zip(row, conversions)) for row in brainbody[1:]]

#calculate averages
avg = [(sum(col))/len(col) for col in zip(*brainBodyConvert)[1:]]

#create squared deviations list of list
bbDeviations = [[(list[1]-avg[0]), (list[2]-avg[1])] for list in brainBodyConvert]
bbDeviationsSquared = [([(row[0] ** 2), (row[1] ** 2)]) for row in bbDeviations]

#calculate variance and standard deviations
bbVariance = [sum(row[i]/61 for row in bbDeviationsSquared) for i in range(len(bbDeviationsSquared[0]))]
bbStandardDeviation = [i ** .5 for i in bbVariance]

#calculate pearson correlation
bodySS = sum(row[0] for row in bbDeviationsSquared)
brainSS = sum(row[1] for row in bbDeviationsSquared)
combVarDiffs = sum((row[0]*row[1]) for row in bbDeviations)
R = combVarDiffs/((bodySS * brainSS) ** .5)

#calculate b1
b1 = (bbStandardDeviation[0]/bbStandardDeviation[1])*R

#least squares equation
print "body weight = %f + %f * brain weight" %(((b1*(-avg[1]))+avg[0]), b1)



