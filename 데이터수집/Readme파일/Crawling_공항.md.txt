# 비행 불가능 여부 크롤링
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
## 라이브러리 로드
```
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
from urllib.request import urlopen
from selenium.webdriver.common.keys import Keys
from xml.etree import ElementTree
import requests
import time
import pandas as pd
import numpy as np
```

## 데이터 로드 압축 파일 중 FOR_GONG이라는 데이터의 경로를 설정한다.
```
data=pd.read_csv('C:\\Users\\qjawl\\Desktop\\빅데이터\\빅데이터프로젝트\\UAM\\20210828\\for_gong.csv',encoding='EUC-KR')
```

## 로드한 데이터 중 주소만 가져오기
```
data_for_c=data.loc[:,['도로명']]
data_for_c=np.array(data_for_c)
data_for_c
```

## Chrome driver, 백업용 파일 경로 재설정 하고 실행
## webdriver.Chrome('Chrome driver 경로') 
## 네트워크 환경에 따라 click,excute_script 이후 에러 발생가능-> tiem.sleep 밑에 추가하면 에러 해결
## 버전 다르면 에러발생가능
```
url='https://map.vworld.kr/map/ws3dmap.do#'
driver = webdriver.Chrome('c:\\Users\\qjawl\\bigdata\\chromedriver.exe')
driver.get(url)

except_list=[]
gong=[]
city_name=[]
si_name=[]
dong_name=[]

###################url 오픈시 팝업창 2개 있음####################
##########################팝업창 닫기############################
try:
    main = driver.window_handles
    for handle in main:
        if handle != main[0]:
            driver.switch_to_window(handle)
            driver.close()
    close_popup=driver.window_handles
    driver.switch_to_window(close_popup[0])
except:
    pass
pop_up_last=driver.find_element_by_xpath('//*[@id="ifrwebglpopup"]')
driver.switch_to.frame(pop_up_last)
map_last=driver.find_element_by_tag_name('map')
area=map_last.find_elements_by_tag_name('area')
area[0].send_keys(Keys.ENTER)
time.sleep(1)
##############################################################
####################공역 구분 기준 선택#######################
driver.switch_to.default_content()
page=driver.find_element_by_class_name('page')
mapsAll=driver.find_element_by_xpath('//*[@id="tabContent2"]/div[5]')
ul=mapsAll.find_element_by_tag_name('ul')
grpcat=ul.find_elements_by_class_name('grpcat')
doro=grpcat[2]
but=doro.find_element_by_id('cat_CAT006').click()
time.sleep(1)
cat=doro.find_element_by_id('CAT006')
dv=cat.find_elements_by_class_name('dv')
hang=dv[1]
hang.click()
ul_hang=hang.find_element_by_tag_name('ul')
li_hang=ul_hang.find_elements_by_tag_name('li')
li_hang[6].find_element_by_tag_name('input').click()
li_hang[14].find_element_by_tag_name('input').click()
li_hang[20].find_element_by_tag_name('input').click()
###################################################################
############################지역선택###############################




for query in data_for_c:
    search=driver.find_element_by_class_name('search')
    search.find_element_by_tag_name('input').send_keys(query)
    a=search.find_element_by_tag_name('a').click()
    time.sleep(1)
    ###################################################################

    page=driver.find_element_by_class_name('page')
    boxing=driver.find_element_by_xpath('//*[@id="shleftSidebar"]/div')
    tabcontent=boxing.find_element_by_id('tabContent1')
    block=tabcontent.find_elements_by_class_name('block')
    ##block[1] -> 도로명 blcok[2]->지번
    try:
        ul=block[1].find_element_by_tag_name('ul')
        li=ul.find_elements_by_tag_name('li')
        li[0].click()
        time.sleep(1)
    except:
        ul=block[2].find_element_by_tag_name('ul')
        li=ul.find_elements_by_tag_name('li')
        try:
            li[0].click()
            time.sleep(1)
        except:
            except_list.append(query)
    #######################################################################
    ###########################화면클릭################################
    page=driver.find_element_by_class_name('page')
    real=page.find_element_by_class_name('real')
    full_spot_map=real.find_element_by_class_name('full-spot-map')
    map_area=full_spot_map.find_element_by_id('maparea')
    map_2d=map_area.find_element_by_id('map2d')
    viewport=map_2d.find_element_by_class_name('ol-viewport')
    canvas=viewport.find_element_by_tag_name('canvas')
    canvas.click()
    time.sleep(1)
    full_spot_map=real.find_element_by_class_name('full-spot-map')
    map_area=full_spot_map.find_element_by_id('maparea')
    # try-> 비행 불가능 지역 (팝업창 열림)
    try: 
        pop_up_gong=map_area.find_element_by_id('mappop_html')
        title=pop_up_gong.find_element_by_class_name('title')
        pop_up_a=title.find_elements_by_tag_name('a')
        pop_up_a[-1].send_keys(Keys.ENTER)
        time.sleep(1)
        gong.append('1')
     #except-> 비행 가능 지역(팝업창 안열림)
    except:
        gong.append('0')
        
    search=driver.find_element_by_class_name('search')
    search.find_element_by_tag_name('input').clear()
    time.sleep(1)
```
## 도로명,지번 주소로 검색 안되는 지역은 except_list에 추가하여 수작업
```
except_list
```
## 공역 결과를 기존 데이터와 합쳐서 백업 -> 경로설정 필수
```
data_for_c=pd.DataFrame(data_for_c)
data_for_c['비행불가능여부']=gong
data_for_c
data_for_c.to_csv('백업파일경로',encoding='EUC-KR')
```


