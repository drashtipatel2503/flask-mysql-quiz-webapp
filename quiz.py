# -*- coding: utf-8 -*-
"""
Created on Fri Mar 26 14:43:36 2021

@author: DRASHTI
"""


import pymysql
import hashlib

from flask import Flask, render_template,request, redirect, session
import base64


from flask_mysqldb import MySQL


mysql=MySQL()
app=Flask(__name__)

app.config['MySQL_USER']='root'
app.config['MYSQL_PASSWORD']='drashti'
app.config['MYSQL_DB']='quiz'
app.config['MYSQL_HOST']='localhost'

mysql.init_app(app)
app.secret_key=hashlib.sha1('abcdef'.encode()).hexdigest()
msg=""
    
    
@app.route('/')
def main():
    return render_template('index.html')


@app.route('/register')
def register():    
        return render_template('register.html')

@app.route('/registerasorganizer')
def registerasorganizer():
    return render_template('register.html')


@app.route('/getroomid')
def getroomid():
    return render_template('getroomid.html')

@app.route('/getroomiddetail' , methods=['POST'])
def getroomiddetail():
    roomjoined=request.form["roomjoined"]
    session['roomjoined']=request.form["roomjoined"]
    email=request.form["email"]
    cur=mysql.connection.cursor()  
    cur.execute("SELECT id from user WHERE `email` LIKE %s",[email])
    q=cur.fetchone()
    session['userjoined']=q

    cur=mysql.connection.cursor()
    
    cur.execute("SELECT qid from paper WHERE `roomid` LIKE %s",[roomjoined])
    q=cur.fetchall()
    print(q)

    q=list(sum(q, ()))
    print(q)

    data=[]
    print(type(q[0]))

    
    for a in range(len(q)):
        
        cur.execute("SELECT * from question WHERE `qid` LIKE %s",[q[a]])
        m=cur.fetchone()
        
     
        data.append(m)
        
    print(data)
    print("data is")
    print(data[0][1])
    len1=len(data)  
    
    
    
    
    return render_template('myquestion.html', data=data, len1=len1)

@app.route('/myquestion')
def myquestion():
    print("IN myq")
    
    
    return render_template('myquestion.html')

@app.route('/myanswer')
def myanswer():
    return render_template('thanks.html')


@app.route('/registeruser', methods=["POST"])
def registeruser():
    
        name=request.form["name"]
        password=request.form["password"]
        email=request.form["email"]
        session['userl']=email 
        
        session['name']=name 
        cur=mysql.connection.cursor()
        
        
        cur.execute("SELECT * from user WHERE `email` LIKE %s",[email])
        q=cur.fetchall()
        print(len(q))
        
        if len(q)>0:
           return  render_template('register.html', msg="Email already registered")
            
        else:  
                
            cur.execute("Insert into user (`name`, `email`, `password`) values(%s, %s, %s)", (name, email, password));
            p=cur.lastrowid
            session['uid']=p 
            mysql.connection.commit()
            cur.close()
            return redirect('getroomid')
              


@app.route('/quiz')
def quiz():
    
        uid=session["uid"]
        cur=mysql.connection.cursor()
        q=cur.execute("SELECT * FROM ANSWER WHERE `ID` LIKE %s",[uid])
        q=cur.fetchall()
        if len(q)>0:
            msg="U already submitted a response"
            return render_template('thanks.html')
        else:   
             return render_template('quiz.html')



@app.route('/submitquiz', methods=["POST"])
def submitquiz():
            ans1=request.form["q1"]
            ans2=request.form["q2"]
            ans3=request.form["q3"]
            uid=session["uid"]
            
            
            cur=mysql.connection.cursor()
            
            cur.execute("Insert into answer (`id`, `q1`, `q2`, `q3`) values(%s, %s, %s, %s)", (uid, ans1, ans2, ans3))
           
            mysql.connection.commit()
            cur.close()
            return redirect('thanks')

@app.route('/thanks')
def thanks():
    return render_template('thanks.html')

@app.route('/createroom')
def createroom():
    return render_template('createroom.html')


@app.route('/createroomwithdetails', methods=['POST'])
def createroomwithdetails():
    
            email=request.form["email"]
            roomid=request.form["roomid"]
            session['roomid']=roomid          
    
            return render_template('setquestion.html')
        
@app.route('/setquestionwithdetails', methods=['POST'])
def setquestionwithdetails():
    
            q=request.form["question"]
            o1=request.form["o1"]
            o2=request.form["o2"]
            o3=request.form["o3"]
            o4=request.form["o4"]
            
            ans=request.form["ans"]
            roomid=session['roomid'] 
            cur=mysql.connection.cursor()
            
            cur.execute("Insert into question (`question`, `o1`, `o2`, `o3`,`o4`, `ans`) values(%s, %s, %s, %s, %s, %s)", (q, o1, o2, o3, o4, ans))
           
            mysql.connection.commit()
            cur.close()
            qid=cur.lastrowid
            session['qid']=qid 
             
            cur=mysql.connection.cursor()
            
            cur.execute("Insert into paper (`qid`, `roomid`, `ans`) values(%s, %s,%s)", (qid, roomid, ans))
           
            mysql.connection.commit()
            cur.close()
            return render_template('setquestion.html')
  
    
@app.route('/setpaper')
def setpaper():
    roomid=session['roomid']
    
    
    return render_template('qpset.html', roomid=roomid)

@app.route('/userresponse', methods=['POST'])
def userresponse():
    uid=session['uid']
    name=session['userl']
    roomid=session['roomjoined']
    print(uid, roomid)
    
    
    cur=mysql.connection.cursor()
            
    cur.execute("SELECT ans FROM paper WHERE `roomid` like %s ",[roomid])
    q=cur.fetchall()
    
    q=list(sum(q, ()))
    print(q)
    print("this")
    mysql.connection.commit()
    ans=[]
    for i in range(len(q)):
        k=str(i)
        ans.append(request.form[k])

    print(ans)
    c=0
    for j in range(len(ans)):
        if ans[j]==q[j]:
            c+=1
            
    print(c)
    session['userscore']=c
        
    cur=mysql.connection.cursor()
            
    cur.execute("INSERT INTO scores (`roomid`,`userid`,`score`) VALUES(%s,%s, %s)", (roomid, name,c))
    
    mysql.connection.commit()
    cur.close()
    
    return render_template('thanks.html')
    
    


@app.route('/viewresult')
def viewresult():
        c=session['userscore']    
        if c<1:
            msg="Better Luck Next time"
        else:
            msg="U are a pro player"
        return render_template('viewresult.html' , count=c, msg=msg)
@app.route('/scoreboard')
def scoreboard():
    
    roomid=session['roomjoined']
    cur=mysql.connection.cursor()
            
    cur.execute("Select * from scores where roomid like %s", [roomid] )
    q=cur.fetchall()
    print(q)
    l=len(q)
    
    
    return render_template('scoreboard.html', data=q, l=l)
 


if __name__=='__main__':
    app.run(debug=True, use_reloader=False)
