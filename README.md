SunAdmin
=====

### An efficient and convenient framework for creating an admin management system. Reduce the number of redundant view codes. And its simplification of the codes about tables and forms in HTML.





NOTE:
----------

#### It's an unfinished version at present, You must invork the commands manually with its absolute path。Maybe you can help me to improve that, Is it right?



How:
----------

### 1  git clone git@git.oschina.net:zhimengsun/sun_admin.git

### 2 config the command
> open your ~/.bash_profile or ~/.bashrc file and fill one line with words like this:

```
export PATH=/Users/foo/sun_admin_path:$PATH

```
> NOTE: after that you need to do: 

```
source ~/.bash_profile
or 
source ~/.bashrc
```


### 3 start a admin project

```
sun_admin new admin_project

```
### 4 创建新Model

```
sun_admin g model hotel:酒店管理 name:string:酒店名 address:string:地址 is_hot:boolean:是否热门 note:text:酒店描述

```

### 5 Enjoy auto generated CRUD without any redundant view codes

  
