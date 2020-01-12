# Project cafe ranking :coffee:

jsp와 mariadb를 이용한 web서비스 구현 실습을 위한 미니 프로젝트입니다. 

### Concept
카페에서 공부하거나 작업하는 사람들(일명 카공족)이 많아지면서 카페가 우후죽순 많아진 것은 사실입니다. 그래서 jsp 실습겸 공부를 하기 좋은 카페인지 아닌지 평가하고 그 결과를 점수화해서 main page에 보여주는 웹페이지를 만들어 보았습니다.

## Collaborators

- [Gahee7071](https://github.com/Gahee707l)  
- [bong199119](https://github.com/bong199119)  
- [howking327](https://github.com/howking327)

## Content(Page)

![image](https://user-images.githubusercontent.com/41675375/72218268-93328580-357c-11ea-86b6-013856fb4de2.png)

**1) main.jsp**  
프로젝트 웹페이지의 메인입니다. 카페 총 평균평점을 목록별로 보여주는 페이지입니다.  
*→ Connected table*  
  ＞ shopinfo: sname(shop name), thumb(thumb nail image)  
  ＞ totalrate: sname(foreign key), mood, light, price, taste (These are total averaged points of all users who rated before)

**2) search.jsp**  
main page에서 사용자가 원하는 카페 이름을 검색하고 나온 결과를 보여주는 페이지입니다.  
*→ Connected table*  
  ＞ shopinfo: sname(shop name), thumb(thumb nail image)  
  ＞ each_shop_rating: id (whether a searching user completed rating before or not)
  ```sql
  SELECT id FROM shopName WHERE id = user_id
  ```
  
**3) view.jsp**
main or search page에서 사용자가 원하는 카페에 대한 자세한 정보와 현재까지의 총 평균평점을 보여주는 페이지입니다.  
*→ Connected table*  
  ＞ shopinfo: sname(shop name), opertime, phone, menu, loc(location), thumb(thumb nail image)  
  ＞ each_shop_rating: id, comm(comment)  
  ＞ totalrate: sname(foreign key), mood, light, price, taste

**4) writeProcess.jsp**
search or view page에서 평가하기(평가완료 상태면 수정하기) 버튼을 클릭했을 시 사용자의 평가상태에 따라 update or write page로 보내주는 역할을 담당하는 process page입니다.  
*→ Connected table*  
  ＞ each_shop_rating: id (whether a searching user completed rating before or not)  
  ＞ call session object: id check 

**5) update.jsp**  
writeProcess에서 건네받은 shopName을 가지고 session object의 사용자 id를 조회해 기존에 평가한 정보들을 가져옵니다. 그 후에 사용자가 수정을 완료하면 해당 내용을 기존의 개별 cafe table(each_shop_rating)에 update합니다.  
*→ Connected table*  
  ＞ each_shop_rating: mood, light, price, taste(These are points which each user rated, not total averaged points), comm  
  ＞ call session object: id check

**6) updateRating.jsp**
update page에서 수정사항을 다 기록하고 수정완료를 클릭하면 해당 정보들을 each_shop_rating(해당 매장) table에 update하고 totalrate에 이 정보들을 가지고 다시 평균낸 점수들을 update해주는 페이지 입니다.  
*→ Connected table*  
  ＞ each_shop_rating:  
  ＞ totalrate: 
 

**7) write.jsp**
writeProcess에서 건네받은 shopName을 가지고 session object의 사용자 id를 조회해 새로 평가 정보를 받습니다. 사용자가 새로 평가를 기록하고 완료 버튼을 클릭하면 해당 내용을 개별 cafe table(each_shop_rating)에 insert합니다.  
*→ Connected table*  
  ＞ call session object: id check

**8) writeRating.jsp**
write page에서 사용자가 평가를 다 수행하고 완료를 하면 해당 정보들을 each_shop_rating(해당 매장) table에 insert하고 totalrate에 이 정보들을 가지고 다시 평균낸 점수들을 update해주는 페이지입니다.  
*→ Connected table*  
  ＞ each_shop_rating:  
  ＞ totalrate: 
  
**9) apply.jsp**


## Database(Tables)

![image](https://user-images.githubusercontent.com/41675375/72217965-7e53f300-3578-11ea-9922-550407d6e225.png)

shopinfo, each_shop_rating, totalrate, apply, member, 

