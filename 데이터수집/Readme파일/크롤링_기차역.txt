# 기차역 크롤링
## 라이브러리 다운로드
```
pip install selenium
```
```
pip install bs4
```
```
pip install pandas
```
```
pip install numpy
```

## 라이브러리 호출
```
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
from urllib.request import urlopen
from selenium.webdriver.common.keys import Keys
import pandas as pd 
import requests
import time
import numpy as np
```

## 크롬드라이버 경로 설정 필수
##  driver=webdriver.Chrome('경로')
```
# 페이지 url 끝에 숫자로 넘어감
default_url='http://info.korail.com/mbs/www/jsp/station/station_list.jsp?id=www_020110020000&category='
driver = webdriver.Chrome('c:\\Users\\qjawl\\bigdata\\chromedriver.exe')
address=[]
# 페이지 url 끝에 숫자 올려가면서 크롤링
# 변수: 첫번째 for문에서 url 돌림
for a in range(15):
    url=default_url+str(a+1)
    driver.get(url)
    ####################맨 마지막 페이지로 이동##########################
    page=driver.find_element_by_id('page')
    page_a=page.find_elements_by_tag_name('a')
    page_a[-1].click()
    ###################################################################
    ######################페이지 개수 확인#############################
    but_page=driver.find_element_by_id('page')
    but_page_a=but_page.find_elements_by_tag_name('a')
    try:
        len_of_page=int(but_page_a[-4].text)
        print(len_of_page)
    except:
        len_of_page=0
    ###################################################################
    #####################페이지수 10개 이상 -> 뒤로가기 버튼 한번 눌러야함###########
    ######################페이지수 10개 이하일때#########################
    #########################페이지 컨트롤############################
    if(int(len_of_page)<=9):
        q=0
        page_index=0
        for i in range(len_of_page+1):
            print('q',q)
            if q == 0:
                table=driver.find_element_by_css_selector('table.table_route')
                tbody=table.find_element_by_tag_name('tbody')
                tr=tbody.find_elements_by_tag_name('tr')
                for i in tr:
                    td=i.find_elements_by_tag_name('td')
                    try:
                        a=td[4].text
                    except:
                        pass ## 비어있는 페이지 때문에 예외처리
                    print(a)
                address.append(a)
            else:
                but_page=driver.find_element_by_id('page')
                but_page_a=but_page.find_elements_by_tag_name('a')
                page_index=-q-3
                print('page_index',page_index)
                but_page_a[page_index].click() ## 맨뒤에서부터 첫번째 페이지로 인덱싱
                time.sleep(1)
######################################################################################

                ######################데이터 긁어오는 부분##################
                table=driver.find_element_by_css_selector('table.table_route')
                tbody=table.find_element_by_tag_name('tbody')
                tr=tbody.find_elements_by_tag_name('tr')
                for i in tr:
                    td=i.find_elements_by_tag_name('td')
                    try:
                        a=td[4].text
                    except:
                        pass ## 비어있는 페이지 때문에 예외처리
                    print(a)
                    address.append(a)
                ############################################################
            q=q+1
    else:
        q=0
        page_index=0
        for i in range(len_of_page-9):
            print('q',q)
            if q == 0:
                table=driver.find_element_by_css_selector('table.table_route')
                tbody=table.find_element_by_tag_name('tbody')
                tr=tbody.find_elements_by_tag_name('tr')
                for i in tr:
                    td=i.find_elements_by_tag_name('td')
                    try:
                        a=td[4].text
                    except:
                        pass ## 비어있는 페이지 때문에 예외처리
                    print(a)
                address.append(a)
            else:
                but_page=driver.find_element_by_id('page')
                but_page_a=but_page.find_elements_by_tag_name('a')
                page_index=-q-3
                print('page_index',page_index)
                but_page_a[page_index].click() ## 맨뒤에서부터 첫번째 페이지로 인덱싱
                time.sleep(1)

                ######################데이터 긁어오는 부분##################
                table=driver.find_element_by_css_selector('table.table_route')
                tbody=table.find_element_by_tag_name('tbody')
                tr=tbody.find_elements_by_tag_name('tr')
                for i in tr:
                    td=i.find_elements_by_tag_name('td')
                    try:
                        a=td[4].text
                    except:
                        pass ## 비어있는 페이지 때문에 예외처리
                    print(a)
                    address.append(a)
                ############################################################
            q=q+1
        but_page=driver.find_element_by_id('page')
        but_page_a=but_page.find_elements_by_tag_name('a')    
        but_page_a[1].click()
        q=0
        for i in range(10):
            print('q',q)
            if q == 0:
                table=driver.find_element_by_css_selector('table.table_route')
                tbody=table.find_element_by_tag_name('tbody')
                tr=tbody.find_elements_by_tag_name('tr')
                for i in tr:
                    td=i.find_elements_by_tag_name('td')
                    try:
                        a=td[4].text
                    except:
                        pass ## 비어있는 페이지 때문에 예외처리
                    print(a)
                address.append(a)
            else:
                but_page=driver.find_element_by_id('page')
                but_page_a=but_page.find_elements_by_tag_name('a')
                page_index=-q-3
                print('page_index',page_index)
                but_page_a[page_index].click() ## 맨뒤에서부터 첫번째 페이지로 인덱싱
                time.sleep(1)

                ######################데이터 긁어오는 부분##################
                table=driver.find_element_by_css_selector('table.table_route')
                tbody=table.find_element_by_tag_name('tbody')
                tr=tbody.find_elements_by_tag_name('tr')
                for i in tr:
                    td=i.find_elements_by_tag_name('td')
                    try:
                        a=td[4].text
                    except:
                        pass ## 비어있는 페이지 때문에 예외처리
                    print(a)
                    address.append(a)
                ############################################################
            q=q+1
driver.quit()
```


## 데이터 프레임으로 변환 후 백업 파일 저장
## 백업파일 경로 설정 필수
```
temp_result=[] 
for i in address:
    try:
        i=i+1
        temp=0
        temp_result.append(temp)
    except:
        temp_result.append(i)        
```
```
null_list=pd.DataFrame(temp_result,columns=['주소']) ## 얻어온 주소를 데이터 프레임으로 만듬
```
```
null_index=null_list[null_list['주소']==0].index ##얻어온 주소에 0이 들어가있음 -> 제거
null_list.drop(null_list.index[null_index],inplace=True)
null_list
```
## 얻어온 주소를 카카오 API를 이용하여 좌표계로 변환
```
lat_list = []
except_list=[]
import requests; from urllib.parse import urlparse
import pandas as pd
for add in add_list:
    for address in add:
        try:
            print(address)
            url = "https://dapi.kakao.com/v2/local/search/address.json?&query=" + address
            result = requests.get(urlparse(url).geturl(),headers={"Authorization":"KakaoAK 799b762511b5374a615b08dfcacc24f7"})
            json_obj = result.json()
            for document in json_obj['documents']:
                val = [document['y'], document['x']]
                lat_list.append(val)
        except: ## 검색 안되는 동네 있을수도 있음 -> except 리스트에 추가하여 확인
            except_list.append(address)
df = pd.DataFrame(lat_list, columns = ['lat', 'lon'])
```
## 백업
```
df.to_csv('백업파일경로')
```
