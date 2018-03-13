
# coding: utf-8

# In[455]:

from stackapi import StackAPI
from datetime import datetime, date, timedelta
import calendar
Stack_key = "WAAOZng12*dnyZoaR4IRng(("
SITE = StackAPI('stackoverflow', key = Stack_key)


# In[456]:

total_days = 3
d1 = date(2017,5,18)
d2 = d1 - timedelta(days=total_days)
timestamp1 = calendar.timegm(d1.timetuple())
timestamp2 = calendar.timegm(d2.timetuple())


# In[457]:

#questions = SITE.fetch('questions', fromdate = timestamp2, todate=timestamp1)
#answers = SITE.fetch('answers', fromdate = timestamp2, todate=timestamp1)


# In[459]:

import numpy as np
import pandas as pd

questions = SITE.fetch('questions', fromdate = timestamp2, todate=timestamp1)
#stackAPI_df = pd.DataFrame.from_dict(SITE.fetch('questions', fromdate = timestamp2, todate=timestamp1, page=1))
#stackAPI_df = pd.DataFrame(questions)

#i=1
#while questions['has_more'try] and i < 10:
#    questions = SITE.fetch('questions', fromdate = timestamp2, todate=timestamp1, page=i+1)
#    stackAPI_df.append(questions, ignore_index=True)
#    i+=1
SAdf = pd.DataFrame.from_dict(questions)
i=1
while questions['has_more'] and i < 100:
    questions = SITE.fetch('questions', fromdate = timestamp2, todate=timestamp1, page=i+1)
    tdf = pd.DataFrame.from_dict(questions)
    SAdf = pd.concat([SAdf, tdf])
    i+=1


# In[460]:

import collections
import operator

Qitems = SAdf['items'].apply(pd.Series)

flattened = []
for x in Qitems.tags: flattened.extend(x)
    
counter=collections.Counter(flattened)
sorted_topics = sorted(counter.items(), key=operator.itemgetter(1), reverse=True)
top20_topics = [i[0] for i in sorted_topics[:20]]


# In[ ]:




# In[461]:

#questions = SITE.fetch('questions', fromdate = timestamp2, todate=timestamp1, tagged = top20_topics)

#SAdf = pd.DataFrame.from_dict(questions)
#i=1
#while questions['has_more'] and i < 100:
#    questions = SITE.fetch('questions', fromdate = timestamp2, todate=timestamp1, page=i+1, tagged = top20_topics)
#    tdf = pd.DataFrame.from_dict(questions)
#    SAdf = pd.concat([SAdf, tdf])
#    i+=1


# In[462]:

SA_df = SAdf['items'].apply(pd.Series)
asker = SA_df['owner'].apply(pd.Series)['user_id']
SA_df['asker'] = pd.Series(asker, index=SA_df.index)

ans_qid = SA_df[~np.isnan(SA_df['accepted_answer_id'])]['accepted_answer_id']
ans_id_list = ans_qid.tolist()
ans_id_list = [int(l) for l in ans_id_list]


# In[ ]:

#asker = SA_df['owner'].apply(pd.Series)['user_id']
#SA_df['asker'] = pd.Series(asker, index=ANSdf.index)


# In[463]:

#answers = SITE.fetch('/answers/{ids}', ids = ans_id_list[:100])
Ans_df = pd.DataFrame()

#if (len(ans_id_list)) % 100 == 0:
#    i = (len(ans_id_list))/100
#else: i = ((len(ans_id_list))/100)+1

i = len(ans_id_list)
while i > 0:
    if i < 100: j = 0
    else: j = i - 100
    answers = SITE.fetch('/answers/{ids}', ids = ans_id_list[j:i])
    Temp_df = pd.DataFrame.from_dict(answers)
    Ans_df = pd.concat([Ans_df, Temp_df])
    i-=100
    
ANSdf = Ans_df['items'].apply(pd.Series)


# In[464]:

##ANSdf = Ans_df['items'].apply(pd.Series)
#ans_qid = SA_df[~np.isnan(SA_df['accepted_answer_id'])]['accepted_answer_id']
#ans_id_list = ans_qid.tolist()
#ans_id_list = [int(l) for l in ans_id_list]
#Ans_df['answerer'] = Ans_df['owner']
answerer = ANSdf['owner'].apply(pd.Series)['user_id']
#answerer = answerer[~np.isnan(answerer)]
#answerer = answerer.tolist()
#answerer = [int(l) for l in answerer]
ANSdf['answerer'] = pd.Series(answerer, index=ANSdf.index)


# In[465]:

SNAdf_full = pd.merge(SA_df, ANSdf, how='outer', on='question_id')
SNAdf = SNAdf_full[['creation_date_x','is_answered', 'view_count', 'asker', 'creation_date_y', 'answerer', 'tags']]


# In[471]:

#SNAdf
SNAdf


# In[ ]:




# In[ ]:




# In[ ]:




# In[387]:

flattened = []
for x in SNAdf.tags: flattened.extend(x)


# In[404]:

import collections
import operator
counter=collections.Counter(flattened)
sorted_topics = sorted(counter.items(), key=operator.itemgetter(1), reverse=True)
top20_topics = [i[0] for i in sorted_topics[:20]]


# In[427]:

sorted_topics


# In[ ]:




# In[406]:

SNAdf['top20'] = []
SNAdf.loc[~SNAdf['column_name'].isin(some_values)]
for x in top20_topics:
    if x in 


# In[ ]:

#SNAdf['top20'] = []
#SNAdf.loc[~SNAdf['column_name'].isin(some_values)]
#for x in top20_topics:
#    if x in 

y for y


# In[ ]:



