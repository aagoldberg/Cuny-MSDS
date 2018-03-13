try:
    import re, csv
except ImportError:
    print "At least one of the imports went wrong, exiting gracefully"

attributenumt = {'buying': 0, 'maint': 1, 'doors': 2, 'persons': 3, 'lugboot':4, 'safety':5, 'class':6}
buyingvalues = {'low': 1, 'med': 2, 'high': 3, 'vhigh': 5}
maintvalues = {'low': 1, 'med': 2, 'high': 3, 'vhigh': 5}
doorvalues = {'2':1, '3':2, '4':3, '5more':4}
personsvalues = {'2':1, '4':2, 'more':3}
lugbootvalues = {'small':1, 'med':2, 'big':3}
safetyvalues = {'low':1, 'med':2, 'high':3}
classvalues = {'unacc':1, 'acc':2, 'good':3, 'vgood':4}
attributenamet = {'buying': buyingvalues, 'maint': maintvalues, 'doors': doorvalues, 'persons': personsvalues, 'lugboot':lugbootvalues, 'safety':safetyvalues, 'class':classvalues}
valueorder = {0: buyingvalues, 1: maintvalues, 2:doorvalues, 3:personsvalues, 4:lugbootvalues, 5:safetyvalues, 6:classvalues}

class ReadCarsCsv:
    "Class that reads cars.data.csv"
    def __init__(self, datadir):
        try:
            with open(datadir, 'rb') as f:
                reader = csv.reader(f)
                self.carsdb = list(reader)
        except IOError:
            print "The file wasn't there, exiting gracefully"

def datacheck(carsdb):
    global valueorder, buyingvalues, maintvalues, doorvalues, personvalues, lugbootvalues, safetyvalues, classvalues
    for i in carsdb:
        for f in range(len(i)):
            if i[f] not in valueorder[f].keys():
                print "There's a blank value somewhere, exiting kind of gracefully"
                break



def partab(carsdb, toporbottom, nrows, attribute, order):
    global attributenamet, attributenumt
    carattkey = attributenumt[attribute]
    carattname = attributenamet[attribute]
    if order == 'asc': sortord = False
    if order == 'desc': sortord = True

    if toporbottom == 'bottom':
        return sorted(carsdb, key=lambda ctable: carattname[ctable[carattkey]], reverse=sortord)[(nrows*-1):]
    if toporbottom == 'top':
        return sorted(carsdb, key=lambda ctable: carattname[ctable[carattkey]], reverse=sortord)[:nrows]

def partc(carsdb, sortby, field1, field2, field3, inrow1, inrow2, order):
    global attributenamet, attributenumt, buyingvalues, maintvalues, doorvalues, personvalues, lugbootvalues, safetyvalues, classvalues
    numfield1, numfield2, numfield3, numsortby = [attributenumt[i] for i in [field1, field2, field3, sortby]]
    namfield1, namfield2, namfield3, namsortby = [attributenamet[i] for i in [field1, field2, field3, sortby]]
    selectedrowscarsdb = []
    pattern = '(high|vhigh)'
    for sublist in carsdb:
        for field in [numfield1, numfield2, numfield3]:
            if re.search(pattern, sublist[field]): selectedrowscarsdb.append(sublist)
    if order == 'asc': sortord = False
    if order == 'desc': sortord = True
    return sorted(selectedrowscarsdb, key=lambda ctable: namsortby[ctable[numsortby]], reverse=sortord)

def partd(carsdb, field1, value1, field2, value2, field3, value3, field4, value4a, value4b):
    global attributenamet, attributenumt, buyingvalues, maintvalues, doorvalues, personvalues, lugbootvalues, safetyvalues, classvalues
    numfield1, numfield2, numfield3, numfield4 = [attributenumt[i] for i in [field1, field2, field3, field4]]
    selectedrowscarsdb = []
    for sublist in carsdb:
        if sublist[numfield1] == value1: selectedrowscarsdb.append(sublist)
        elif sublist[numfield2] == value2: selectedrowscarsdb.append(sublist)
        elif sublist[numfield3] == value3: selectedrowscarsdb.append(sublist)
        elif sublist[numfield4] == value4a or value4b: selectedrowscarsdb.append(sublist)
    with open('AGhw3d.csv', 'wb') as f:
        listwriter = csv.writer(f, delimiter=',')
        listwriter.writerows(selectedrowscarsdb)

if __name__ == "__main__":
    datadir = 'cars.data.csv'
    carsdata1 = ReadCarsCsv(datadir)

    print datacheck(carsdata1.carsdb)
    print partab(carsdata1.carsdb, "top", 10, "safety", "desc")
    print partab(carsdata1.carsdb, "bottom", 15, "maint", "asc")
    print partc(carsdata1.carsdb, "doors", "buying", "maint", "safety", "high", "vhigh", "asc")
    print partd(carsdata1.carsdb, "buying", "vhigh", "maint", "med", "doors", "4", "persons", "4", "more")
