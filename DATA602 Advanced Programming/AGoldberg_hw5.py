import bs4, urllib2, re, json
from alchemyapi import AlchemyAPI
alchemyapi = AlchemyAPI()

#retrieve and parse html
url = "http://en.chessbase.com/post/magnus-carlsen-and-vishy-anand-clash-again"
html = urllib2.urlopen(url).read()
soup=bs4.BeautifulSoup(html, "html.parser")

#select only intended blog story
blogContentList = []
for blog_tag in soup.find_all("div", { "class" : "blog-content"}):
    blogContentList.append(blog_tag.text)

mainEntry = blogContentList[0]

#clean it up
mainEntryCondensed = " ".join(line.strip() for line in mainEntry.split("\n"))
myText = re.sub('Twittear.*', '', mainEntryCondensed)

#call the alchemyapi for the top 10 keywords
response = alchemyapi.keywords("text", myText, {'maxRetrieve': 10})

if response['status'] == 'OK':
    print('## Response Object ##')
    print(json.dumps(response, indent=4))

    print('')
    print('## Keywords ##')
    for keyword in response['keywords']:
        print('text: ' + keyword['text'].encode('utf-8'))
        print('relevance: ' + keyword['relevance'])

        print('')
else:
    print('Error in keyword extaction call: ', response['statusInfo'])


