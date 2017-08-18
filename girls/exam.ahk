#NoEnv
SendMode Input
DetectHiddenWindows On
DetectHiddenText, On
CoordMode, Pixel, Screen
SetWorkingDir %A_ScriptDir%


Gui, Add, ListView, r10 , log
gui, show,,catchplz



loop{
	if(nSearch(764, 22, 810, 65, 80, "gunsuend.png")=1){
		nClick(400, 230, 30)
	}else if(nSearch(450, 336, 520, 383, 80, "gunsustart.png")=1){
		sleep(1000)
		nClick(474,361,4)
	}
	sleep(5000)
}

^!z::ExitApp




nClick(x, y,range)
{
	Random,rX,-5*range,5*range
	Random,rY,-3*range,3*range
	x:=x+rX
	y:=y+rY
	IParam := x|y<<16 
	WinGet, ActiveID, ID, dstn
	PostMessage, 0x201, 1, %IParam%, , ahk_id %ActiveID%
	sleep(200)
	PostMessage, 0x202, 0, %IParam%, , ahk_id %ActiveID%
	sleep,50
}

sleep(delay:=1000){
	Random,ran,1.0,2.5
	multiple:=1
	sleep, delay*ran*multiple
	return
}

nSearch(x1,y1,x2:=0,y2:=0,dp:=80,img:=" ",count:=1)
{
	if(x2=0 and y2=0){
		x2:=x1+70
		y2:=y1+70
	}
	loop, %count%{
		ImageSearch, , ,x1,y1,x2,y2, *TransBlack *%dp% %A_ScriptDir%\image\%img%
		if(ErrorLevel=2){
			LV_Insert(1,,img "파일을 찾을 수 없습니다.")
		}else if(Errorlevel=1){
			LV_Insert(1,,"현재 화면에" img "이(가) 없습니다.")
		}else{
			LV_Insert(1,,img "을(를) 찾았습니다.")
			return 1
		}
		if(count>1){
			sleep,100
		}
	}
	return 0
}

