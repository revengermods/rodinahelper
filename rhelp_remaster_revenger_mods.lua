script_name('Rodina helper') 
script_author('Revenger mods') 
script_description('Helper') 

local imgui = require 'imgui'
local encoding = require 'encoding'
local inicfg = require 'inicfg'
local keys = require "vkeys"
local hook = require 'lib.samp.events'
local dlstatus = require('moonloader').download_status
require "lib.moonloader" -- ����������� ����������

encoding.default = 'CP1251'
u8 = encoding.UTF8

local mainIni = inicfg.load({
config =
{
sbiv = false,
spawncara = false,
tlf = false,
balloon = false,
arm = false,
drift = false,
msk = false,
cleatchat = false,
fovfish = false,
ztimerstatus = false,
time = false,
lock = false,
jlock = false,
recar = false,
fcar = false,
vr = false,
act = false,
flood = false,
inv = false,
doppiar = false,
vskin = false,
chatsms = " ",
rtsms = " ",
famsms = " ",
smsbc = " ",
smsvip = " ",
chasi = " ",
keyAdminMenu = " "
}
}, "Rodina Helper")

local tlf = imgui.ImBool(mainIni.config.tlf)
local balloon = imgui.ImBool(mainIni.config.balloon)
local arm = imgui.ImBool(mainIni.config.arm)
local msk = imgui.ImBool(mainIni.config.msk)
local ztimerstatus = imgui.ImBool(mainIni.config.ztimerstatus)
local time = imgui.ImBool(mainIni.config.time)
local lock = imgui.ImBool(mainIni.config.lock)
local sbiv = imgui.ImBool(mainIni.config.sbiv) 
local fovfish = imgui.ImBool(mainIni.config.fovfish) 
local drift = imgui.ImBool(mainIni.config.drift)
local cleatchat = imgui.ImBool(mainIni.config.cleatchat)
local slider = imgui.ImInt(15000)
local jlock = imgui.ImBool(mainIni.config.jlock)
local vskin = imgui.ImBool(mainIni.config.vskin)
local recar = imgui.ImBool(mainIni.config.recar)
local fcar = imgui.ImBool(mainIni.config.fcar)
local fisheye = imgui.ImBool(mainIni.config.fisheye)
local vr = imgui.ImBool(mainIni.config.vr)
local doppiar = imgui.ImBool(mainIni.config.doppiar)
local timer = imgui.ImBool(mainIni.config.timer)
local inv = imgui.ImBool(mainIni.config.inv)
local lays = imgui.ImBool(mainIni.config.lays)
local flood = imgui.ImBool(mainIni.config.flood)
local spawncara = imgui.ImBool(mainIni.config.spawncara)
local smsbc = imgui.ImBuffer(''..mainIni.config.smsbc, 500) 
local chatsms = imgui.ImBuffer(''..mainIni.config.chatsms, 500) 
local rtsms = imgui.ImBuffer(''..mainIni.config.rtsms, 500) 
local famsms = imgui.ImBuffer(''..mainIni.config.famsms, 500)
local smsvip = imgui.ImBuffer(''..mainIni.config.smsvip, 500)
local chasi = imgui.ImBuffer(''..mainIni.config.chasi, 500)
local status = inicfg.load(mainIni, 'Rodina Helper.ini')


if not doesFileExist('moonloader/config/Rodina Helper.ini') then inicfg.save(mainIni, 'Rodina Helper.ini') end

local colorslist = imgui.CreateTextureFromFile(getWorkingDirectory()..'/Rodina Helper/colors.png')

update_state = false

local script_vers = 2
local script_vers_text = "2.00"

local update_url = "https://raw.githubusercontent.com/revengermods/rodinahelper/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/Rodina Helper/update.ini" 

local script_url = "https://raw.githubusercontent.com/revengermods/rodinahelper/main/rhelp_remaster_revenger_mods.lua" -- ��� ���� ������
local script_path = thisScript().path

local setskin = 0
local menu = 1
------------------imgui----------------------
local main_window_state = imgui.ImBool(false)
local id_widnow_state = imgui.ImBool(false)
local color_widnow_state = imgui.ImBool(false)
----------------------------------------------

function imgui.OnDrawFrame()
  imgui.ShowCursor = main_window_state.v or id_widnow_state or color_widnow_state
  if main_window_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(720, 434), imgui.Cond.FirstUseEver)
		if not window_pos then
			ScreenX, ScreenY = getScreenResolution()ScreenX, ScreenY = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
		end
	  	imgui.Begin('Rodina Helper remaster | v2.0', main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)
	  	imgui.CenterText(u8" ")
	  	imgui.SetCursorPos(imgui.ImVec2(6, 30))
	  	imgui.BeginChild("##MainWindow", imgui.ImVec2(350, 350), true, imgui.WindowFlags.NoScrollbar)
        imgui.Checkbox(u8"�������� �������� ��������� �� ����", flood)
        imgui.SameLine()
				imgui.TextQuestion(u8"������ ������� ������ �� ���� ����� ��������� ���:\n���������� �����, ������ ������� � �.�" )
			  	imgui.Checkbox(u8"��������/�������� ����������", lock)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� �� ������� L �� ��������/�������� ���� ���������")
				imgui.Checkbox(u8"����� ���������� �� �������",spawncara)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� �������� ���� ����� ��������� ���� � ������� �� ������ (����� ����� ����� �����)")
				imgui.Checkbox(u8"��������� ����", fcar)
				imgui.SameLine()
				imgui.TextQuestion(u8"��������� - ALT + H")
				imgui.Checkbox(u8"������� ����",recar)
		    	imgui.SameLine()
				imgui.TextQuestion(u8"��������� - ALT + Y")
				imgui.Checkbox(u8"������� � ����", inv)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ��������� ������ Alt + 3 �� ���������� ���������� ������ � ����.���� ����� ��� ������� � ����� �� ���������� ���� ����")
				imgui.Checkbox(u8"����������", balloon)
				imgui.SameLine()
				imgui.TextQuestion(u8"���������: ALT + C (�������)\n������ ��� ������ ���� � �.�\n(����� �������������� ���������� ������� ������ ������!)")
				imgui.Checkbox(u8"�������", tlf)
				imgui.SameLine()
				imgui.TextQuestion(u8"��������� - ALT + 1")
				imgui.Checkbox(u8"�����", msk)
				imgui.SameLine()
				imgui.TextQuestion(u8"��������� - ALT + 4")
				imgui.SameLine()
				imgui.Checkbox(u8"����������", arm)
				imgui.SameLine()
				imgui.TextQuestion(u8"��������� - ALT + 2")		
				imgui.Checkbox(u8"���� ����� ��������",sbiv)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ������� ������� Q ���������� /anims 125")
				imgui.Checkbox(u8"Z-Timer", ztimerstatus)
				imgui.SameLine()
				imgui.TextQuestion(u8"����� ������ ����� Z, �������� ������ 600 ������")
				imgui.Checkbox(u8"����� �����", vskin)
				imgui.SameLine()
				imgui.TextQuestion(u8"������ �������� ����� � ������\n(92 � 99 ����� �� ������������)")
				imgui.Checkbox(u8"�������� ���", cleatchat)
				imgui.SameLine()
				imgui.TextQuestion(u8"��������� - �")
				imgui.Checkbox(u8"�����", drift)
				imgui.SameLine()
				imgui.TextQuestion(u8"��������� - Shift, ���������� - A,D\n(����� �������������� ���������� ������� ������ ������!)")		
				imgui.Checkbox(u8"FishEyeEffect", fovfish)
				imgui.SameLine()
				imgui.TextQuestion(u8"���� ������ ���� ������\n(����� �������������� ���������� ������� ������ ������!))")
	  			imgui.EndChild()
	  		imgui.SetCursorPos(imgui.ImVec2(10, 385))
			if imgui.Button(u8'��������� ���������',imgui.ImVec2(171,45)) then
				sampAddChatMessage("{00C091}[Rodina Helper] {ffffff}��������� ���������",-1)
				mainIni.config.balloon = balloon.v 
				mainIni.config.drift = drift.v 
				mainIni.config.arm = arm.v
				mainIni.config.fovfish = fovfish.v
				mainIni.config.msk = msk.v
				mainIni.config.ztimerstatus = ztimerstatus.v
				mainIni.config.vskin = vskin.v
				mainIni.config.cleatchat = cleatchat.v
				mainIni.config.time = time.v
				mainIni.config.spawncara = spawncara.v
				mainIni.config.lock = lock.v
				mainIni.config.jlock = jlock.v
				mainIni.config.recar = recar.v
				mainIni.config.fcar = fcar.v
				mainIni.config.sbiv = sbiv.v
				mainIni.config.smsbc = smsbc.v
				mainIni.config.chatsms = chatsms.v
				mainIni.config.rtsms = rtsms.v
				mainIni.config.famsms = famsms.v
				mainIni.config.flood = flood.v
				mainIni.config.inv = inv.v
				mainIni.config.smsvip = smsvip.v
				mainIni.config.chasi = chasi.v
				mainIni.config.doppiar = doppiar.v
				inicfg.save(mainIni, 'Rodina Helper.ini')
			end
			imgui.SetCursorPos(imgui.ImVec2(360, 30))
			imgui.BeginChild("##bindercommand", imgui.ImVec2(350, 350), true) 	
				imgui.Text(u8"���������: /Piar")
				imgui.SameLine()
				imgui.SliderInt('��������', slider, 15000, 300000)
				imgui.InputText(u8"������� � /vr", chatsms)
				imgui.Checkbox(u8"�������� ��� ����", doppiar)
				imgui.InputText(u8"��� ����", famsms)
				imgui.Checkbox(u8"����", time)
				imgui.SameLine()
				imgui.PushItemWidth(70)
				imgui.InputText(u8"��������� �����", chasi)
				imgui.SameLine()
				imgui.TextQuestion(u8"��� ��������� ������ EZ �� ���������� �� ����")
        imgui.Separator()
        -- avtor
        imgui.Text(u8'�����:') imgui.SameLine() imgui.Link('https://vk.com/srevenreg', 'revenger mods')
        -- support
        imgui.Text(u8'����� ���?') imgui.SameLine() imgui.Link('https://vk.com/im?sel=-217349315', u8'��� ����!')
		imgui.Separator()
		if imgui.Button(u8'������ ����������� ������',imgui.ImVec2(330,20)) then
			sampAddChatMessage("{00C091}/bizinfo - {ffffff}/biz",-1)
			sampAddChatMessage("{00C091}/fixmycar - {ffffff}/car",-1)
			sampAddChatMessage("{00C091}/findihouse - {ffffff}/fh",-1)
			sampAddChatMessage("{00C091}/findibiz - {ffffff}/fbiz",-1)
			sampAddChatMessage("{00C091}/showpass - {ffffff}/pass ",-1)
			sampAddChatMessage("{00C091}/unrentcar - {ffffff}/urc",-1)
        end
        imgui.EndChild()
		    	imgui.SetCursorPos(imgui.ImVec2(185, 385))
		    	if imgui.Button(u8"������������� ������", imgui.ImVec2(171,45)) then
		    		thisScript():reload()
				end
					imgui.SetCursorPos(imgui.ImVec2(360, 385))
		    	if imgui.Button(u8"���� ������", imgui.ImVec2(171,45)) then
					sampAddChatMessage("{00C091}[Rodina Helper] {ffffff}��������� ��� �� ��� �������� ���� �������� skinchanger!",-1)
						sampProcessChatInput('/ids')
				end		
					imgui.SetCursorPos(imgui.ImVec2(535, 385))
		    	if imgui.Button(u8"�������", imgui.ImVec2(171,45)) then
		    		main_window_state.v = not main_window_state.v
		    	end
	    	imgui.End()
	   	end
		
	   if id_widnow_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(408, 420), imgui.Cond.FirstUseEver)
		if not window_pos then
			ScreenX, ScreenY = getScreenResolution()ScreenX, ScreenY = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
		end
	 	imgui.Begin('Skinchanger', id_widnow_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)
	  	imgui.CenterText(u8" ")
	  	imgui.SameLine()
	  	imgui.SetCursorPos(imgui.ImVec2(4, 25))
	  	imgui.BeginChild('left', imgui.ImVec2(123, -10), true)
		  if imgui.Selectable(u8"������������", menu == 1) then menu = 1
		  elseif imgui.Selectable(u8"��������", menu == 2) then menu = 2
		  elseif imgui.Selectable(u8"������������", menu == 3) then menu = 3
		  elseif imgui.Selectable(u8"�����/�����", menu == 4) then menu = 4
		  elseif imgui.Selectable(u8"������", menu == 5) then menu = 5 end
		  imgui.EndChild()
		  imgui.SameLine()	
		  imgui.BeginChild('right', imgui.ImVec2(0, -10), true) 	
		if menu == 1 then
			if imgui.Button(u8"���� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 1194')
			end
			if imgui.Button(u8"���� ��� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2635')
			end	
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10265')
			end	
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2648')
			end		
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 6145')
			end	
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 5892')
			end	
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 5890')
			end	
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 6146')
			end		
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10740') 
			end
			-- old
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 949')
			end		
			if imgui.Button(u8"���� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 951')
			end		
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 952')
			end		
			if imgui.Button(u8"���� ���������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 953')
			end		
			if imgui.Button(u8"���� �����������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 954')
			end		
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 956')
			end		
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 957')
			end		
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 962')
			end	
			if imgui.Button(u8"���� ������ ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 963')
			end	
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 965')
			end	
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 1198')
			end	
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 1206')
			end		
			-- new
			if imgui.Button(u8"���� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2077')
			end		
			if imgui.Button(u8"���� ���", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2074')
			end		
			if imgui.Button(u8"���� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 13918')
			end	
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10741')
			end	
			if imgui.Button(u8"���� ��� ����� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2253')
			end	
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2075')
			end		
		elseif menu == 5 then
			if imgui.Button(u8"���� Gta4", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2252')
			end			
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10366')
			end		
			if imgui.Button(u8"���� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10364')
			end
			if imgui.Button(u8"���� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 1832')
			end			
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10344')
			end		
			if imgui.Button(u8"���� ����������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9977')
			end		
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9688')
			end																																																	
		elseif menu == 3 then
			if imgui.Button(u8"���� ���", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 5779')
			end		
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9985')
			end		
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9695')
			end	
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9696')
			end	
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9697') -- 9750 9975 9976 9978
			end	
			if imgui.Button(u8"���� ���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9750')
			end	
			if imgui.Button(u8"���� ����������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9975')
			end	
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9976')
			end	
			if imgui.Button(u8"���� ���������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9978')
			end																																										
		elseif menu == 2 then
			if imgui.Button(u8"���� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9739')
			end	
			if imgui.Button(u8"���� ����� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9740')
			end	
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10554')
			end		
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10475')
			end	
			if imgui.Button(u8"���� ���", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10557')
			end	
			if imgui.Button(u8"���� ����� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10553')
			end	
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10552')
			end	
			if imgui.Button(u8"���� ������ ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10742') 
			end	
			if imgui.Button(u8"���� ��������� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9980') 
			end																						
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2310') 
			end		
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2248') 
			end			
			if imgui.Button(u8"���� ����� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2256') 
			end		
			if imgui.Button(u8"���� ���������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2255') 
			end		
			if imgui.Button(u8"���� �����������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2250') 
			end	
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9774') 
			end	 
			if imgui.Button(u8"���� ���������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10209') 
			end	 
			if imgui.Button(u8"���� ��� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2257') 
			end	 
			if imgui.Button(u8"���� ��������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9775') 
			end			
			if imgui.Button(u8"���� ���� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10201') 
			end		
			if imgui.Button(u8"���� ������ ����������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10210') 
			end		
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2241') 
			end		
			if imgui.Button(u8"���� ��������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10263') 
			end		
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9840') 
			end		
			if imgui.Button(u8"���� ����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 9841') 
			end			
			if imgui.Button(u8"���� ������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2076') 
			end		
			if imgui.Button(u8"���� �����", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10813') 
			end		
			if imgui.Button(u8"���� ���", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10268') 
			end		
			if imgui.Button(u8"���� �������", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 2073') 
			end																																									
		elseif menu == 4 then
			-- ��		
			if imgui.Button(u8"����������� ������ 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 108') 
			end	
			if imgui.Button(u8"����������� ������ 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 109') 
			end	
			if imgui.Button(u8"����������� ������ 3 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 110') 
			end	
			if imgui.Button(u8"����������� ������ 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 47') 
			end	
			if imgui.Button(u8"����������� ������ 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10578') 
			end	
			-- ��
			if imgui.Button(u8"׸���� ����� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 100') 
			end	
			if imgui.Button(u8"׸���� ����� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 102') 
			end	
			if imgui.Button(u8"׸���� ����� 3 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 103') 
			end	
			if imgui.Button(u8"׸���� ����� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 104') 
			end	
			if imgui.Button(u8"׸���� ����� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10579') 
			end				
			-- ��
			if imgui.Button(u8"��������� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 105') 
			end	
			if imgui.Button(u8"��������� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 106') 
			end	
			if imgui.Button(u8"��������� 3 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 107') 
			end	
			if imgui.Button(u8"��������� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 270') 
			end	
			if imgui.Button(u8"��������� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10580') 
			end					
			-- ��
			if imgui.Button(u8"�������� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 114') 
			end	
			if imgui.Button(u8"�������� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 115') 
			end	
			if imgui.Button(u8"�������� 3 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 116') 
			end	
			if imgui.Button(u8"�������� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 292') 
			end	
			if imgui.Button(u8"�������� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 319') 
			end				
			-- �� ������� �����
			if imgui.Button(u8"������� ����� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 305') 
			end	
			if imgui.Button(u8"������� ����� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 306') 
			end	
			if imgui.Button(u8"������� ����� 3 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 307') 
			end	
			if imgui.Button(u8"������� ����� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 308') 
			end	
			if imgui.Button(u8"������� ����� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 340') 
			end					
			-- �� ���������� �����
			if imgui.Button(u8"���������� ����� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10648') 
			end	
			if imgui.Button(u8"���������� ����� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10649') 
			end	
			if imgui.Button(u8"���������� ����� 3 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10650') 
			end	
			if imgui.Button(u8"���������� ����� 4 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10651') 
			end	
			if imgui.Button(u8"���������� ����� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 383') 
			end	
			-- ��	
			if imgui.Button(u8"���������� ����� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10644') 
			end	
			if imgui.Button(u8"���������� ����� 2 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10645') 
			end	
			if imgui.Button(u8"���������� ����� 3 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10646') 
			end	
			if imgui.Button(u8"���������� ����� 4 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 10647') 
			end	
			if imgui.Button(u8"���������� ����� 1 (�)", imgui.ImVec2(245,22)) then
				sampProcessChatInput('/skin 382') 
			end																														
		end		
		imgui.EndChild()
		imgui.End()
	end  

	if color_widnow_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(1600, 700), imgui.Cond.FirstUseEver)
		if not window_pos then
			ScreenX, ScreenY = getScreenResolution()ScreenX, ScreenY = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(ScreenX / 2 , ScreenY / 2), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
		end	
		imgui.Begin(u8'ID ������ | rodina helper', color_widnow_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)
		imgui.CenterText(u8" ")	
		imgui.Image(colorslist, imgui.ImVec2(1584, 726))
		imgui.End()
	end  	
end
function main()
	while not isSampAvailable() do wait(0) end
	sampRegisterChatCommand("piar", function() 
	act = not act; sampAddChatMessage(act and '{01A0E9}������� ��������!' or '{01A0E9}������� ���������!', -1)
		if act then
    		 piar()
   		 end
	end)
	--------------- ������� ���� --------------
	sampRegisterChatCommand("rhelp", function()
      main_window_state.v = not main_window_state.v
    end)
	sampRegisterChatCommand("ids", function()
      id_widnow_state.v = not id_widnow_state.v
    end)
	sampRegisterChatCommand("colors", function()
		color_widnow_state.v = not color_widnow_state.v
	end)
	----------------------------------------------
	---------------���������� �������-------------
	sampRegisterChatCommand('fh', function(num) 
		sampSendChat('/findihouse '..num) 
	end)	
	sampRegisterChatCommand("skin", nsc_cmd)

	sampRegisterChatCommand('fbiz', function(num) 
			sampSendChat('/findibiz '..num) 
	end)
	sampRegisterChatCommand('biz', function(num) 
		sampSendChat('/bizinfo'..num) 
	end)
	sampRegisterChatCommand('car', function(num) 
		sampSendChat('/fixmycar '..num) 
	end) 
     sampRegisterChatCommand('pass', function(num) 
	sampSendChat('/showpass '..num) 
	end)
	sampRegisterChatCommand('urc', function(num) 
		sampSendChat('/unrentcar'..num) 
	end)
	-----------------------------------------------
	sampAddChatMessage("{00C091}[RodinaHelper]{FFFFFF} ������� ��������! ���������: {00C091}/rhelp",-1)

	downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)

    while true do
    	wait(0)
	  imgui.Process = main_window_state.v or id_widnow_state.v or color_widnow_state.v
	  skinid = getCharModel(PLAYER_PED) -- ���������� �����
		if inv.v and wasKeyPressed(0x33) and isKeyDown(0x12) then
			local veh, ped = storeClosestEntities(PLAYER_PED)
			local _, id = sampGetPlayerIdByCharHandle(ped)
			if _ then
					sampSendChat('/faminvite '..id)
			end
		end
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("{00C091}[Rodina Helper] {FFFFFF}������ ������� ��������!", -1)
                    thisScript():reload()
                end
            end)
            break
        end		
		if tlf.v then
			if isKeyDown(VK_MENU) and isKeyJustPressed(VK_1) then
				sampSendChat("/usemed")
			end
		end		
		if arm.v then
			if isKeyDown(VK_MENU) and isKeyJustPressed(VK_2) then
				sampSendChat("/armour")
			end
		end	
		if msk.v then
			if isKeyDown(VK_MENU) and isKeyJustPressed(VK_4) then
				sampSendChat("/mask")
			end
		end	
		if recar.v and not sampIsCursorActive() then
			if isKeyDown(VK_MENU) and isKeyJustPressed(VK_Y) then
				sampSendChat("/repcar")
			end
		end
		if fcar.v and not sampIsCursorActive() then
			if isKeyDown(VK_MENU) and isKeyJustPressed(VK_H) then
				sampSendChat("/fillcar")
			end
		end					
		if drift.v then
			if isCharInAnyCar(playerPed) then 
					local car = storeCarCharIsInNoSave(playerPed)
					local speed = getCarSpeed(car)
					isCarInAirProper(car)
					setCarCollision(car, true)
						if isKeyDown(VK_LSHIFT) and isVehicleOnAllWheels(car) and doesVehicleExist(car) and speed > 5.0 then
						setCarCollision(car, false)
							if isCarInAirProper(car) then setCarCollision(car, true)
							if isKeyDown(VK_A)
							then 
							addToCarRotationVelocity(car, 0, 0, 0.15)
							end
							if isKeyDown(VK_D)
							then 			
							addToCarRotationVelocity(car, 0, 0, -0.15)	
							end
						end
					end
				end
			end
		if balloon.v and isKeyDown(0x12) and isKeyDown(0x43) then setVirtualKeyDown(1, true) wait(50) setVirtualKeyDown (1, false) end


		if sbiv.v then
			if testCheat("Q") and not isCharInAnyCar(PLAYER_PED) then
               sampSendChat("/anims 125")
			end
		end
		if spawncara.v then
			if wasKeyPressed(4) then
              if not isCharOnFoot(playerPed) then
                 car = storeCarCharIsInNoSave(playerPed)
                 _, id = sampGetVehicleIdByCarHandle(car)
                 sampSendChat('/fixmycar '..id)
                 sampAddChatMessage("{00C091}[Rodina Helper] {ffffff}�� ������� ���������� ���� ���",-1)
				end
			end
       end

			if ztimer == 0 then
				ztimer = ztimer - 1
				msg('����� ����� �������� ����������� �������, ������ ��������� �������� �� ����.')
				wait(1000)
			end       
		if ztimerstatus.v then
		if id == 0 and title:find('��������!') then
				lua_thread.create(function() 
				msg('�� �������� ��� ������� ����������, ������ 10 ����� �����.')
				ztimer = 600
					while ztimer > 0 do
						printStringNow(u8'Z-Timer: ~r~~h~'..ztimer..' ~w~sec.', 1500) 
						ztimer = ztimer - 1
						wait(1000)
					end
				end)
				return false
		end
	end
		if cleatchat.v then
			 		if testCheat("O") and not sampIsChatInputActive() and not sampIsDialogActive() and not sampIsCursorActive() then
			 			for i=0, 30 do
						sampAddChatMessage("",-1)
					end	
		end
	end	

		if time.v then
			if testCheat("ez") and not sampIsCursorActive() then
				sampSendChat(u8:decode(chasi.v))
				wait(1200)
				sampSendChat("/time")
				wait(1200)
				sampSendChat ("/do �� �����  "..os.date('%H:%M:%S'))
			end 
		end
	
		if fovfish.v then
			if isCurrentCharWeapon(PLAYER_PED, 34) and isKeyDown(2) then
				if not locked then 
					cameraSetLerpFov(70.0, 70.0, 1000, 1)
					locked = true
				end
			else
				cameraSetLerpFov(101.0, 101.0, 1000, 1)
				locked = false
			end
		end

		if jlock.v and not sampIsChatInputActive() then
			if testCheat("jl") then
				sampSendChat("/jlock")
			end
		end
		if lock.v and not sampIsChatInputActive() then
			if testCheat("l") then
				sampSendChat("/lock")
			end
		end
	end
end

function hook.onServerMessage(color, text)
	if flood.v then
		if text:find("~~~~~~~~~~~~~~~~~~~~~~~~~~") and not text:find('�������') then
			return false
		end
		if text:find("- �������� �������") and not text:find('�������') then
			return false
		end
		if text:find("- �������� �����") and not text:find('�������') then
			return false
		end
		if text:find("- ����� � ���������") and not text:find('�������') then
			return false
		end
		if text:find("������") and not text:find('�������') then
			return false
		end
		if text:find("���� ���") and not text:find('�������') then
			return false
		end
		if text:find("����� ������") and not text:find('�������') then
			return false
		end
		if text:find("���� ���") and not text:find('�������') then
			return false
		end
		if text:find("����� ��������������") and not text:find('�������') then
			return false
		end
		if text:find("������ �������") and not text:find('�������') then
			return false
		end		
		if text:find("����������� �������") and not text:find('�������') then
			return false
		end
		if text:find("���������� �������� �����") and not text:find('�������') then
			return false
		end
		if text:find("��� ����") and not text:find('�������') then 
			return false
		end
		if text:find('News') and not text:find('�������') and not text:find('- |') and not text:find('���.') then 
			return false 
		end
	end
end

function piar()
	lua_thread.create(function()
		if act and doppiar.v then
		  sampSendChat(u8:decode(chatsms.v))
		  wait(1200)
	      sampSendChat(u8:decode(famsms.v))
          wait(slider.v)
		  return true
		end
		if act then
		  sampSendChat(u8:decode(chatsms.v))
		  wait(slider.v)
		  return true
		end
	end)
end

function nsc_cmd( arg )
	if vskin.v then
		if #arg == 0 then 
			sampAddChatMessage("{00C091}[Rodina Helper] {ffffff}/skin ID",-1)
		else
			local skinid = tonumber(arg)
			if skinid == 0 then 
				setskin = 0
			else
				setskin = skinid
				_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
				set_player_skin(id, setskin)
			end
		end
	else
		sampAddChatMessage("{00C091}[Rodina Helper] {ffffff}������� skinchanger �� �������� � ������� ����.",-1)
	end
end

function imgui.Link(link,name,myfunc)
	myfunc = type(name) == 'boolean' and name or myfunc or false
	name = type(name) == 'string' and name or type(name) == 'boolean' and link or link
	local size = imgui.CalcTextSize(name)
	local p = imgui.GetCursorScreenPos()
	local p2 = imgui.GetCursorPos()
	local resultBtn = imgui.InvisibleButton('##'..link..name, size)
	if resultBtn then
		if not myfunc then
		    os.execute('explorer '..link)
		end
	end
	imgui.SetCursorPos(p2)
	if imgui.IsItemHovered() then
		imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], name)
		imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + size.y), imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
	else
		imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.Button], name)
	end
	return resultBtn
end

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end

function apply_custom_style() -- ����
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local ImVec2 = imgui.ImVec2
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	style.WindowPadding = imgui.ImVec2(8, 8)
	style.WindowRounding = 6
	style.ChildWindowRounding = 5
	style.FramePadding = imgui.ImVec2(5, 3)
	style.FrameRounding = 3.0
	style.ItemSpacing = imgui.ImVec2(5, 4)
	style.ItemInnerSpacing = imgui.ImVec2(4, 4)
	style.IndentSpacing = 21
	style.ScrollbarSize = 10.0
	style.ScrollbarRounding = 13
	style.GrabMinSize = 8
	style.GrabRounding = 1
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
	style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

	colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
	colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
	colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
	colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
	colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
	colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
	colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
	colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
	colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
	colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
	colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
	colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
	colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.12, 0.12, 0.12, 1.00);
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.36, 0.36, 0.36, 1.00);
	colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
	colors[clr.CheckMark]              = ImVec4(0.00, 0.75, 0.57, 1.00);
	colors[clr.SliderGrab]             = ImVec4(0.00, 0.75, 0.57, 1.00);
	colors[clr.SliderGrabActive]       = ImVec4(0.00, 0.71, 0.46, 1.00);
	colors[clr.Button]                 = ImVec4(0.00, 0.75, 0.57, 1.00);
 	colors[clr.ButtonHovered]          = ImVec4(0.00, 0.94, 0.60, 1.00);
  	colors[clr.ButtonActive]           = ImVec4(0.00, 0.71, 0.46, 1.00);
	colors[clr.Header]                 = ImVec4(0.00, 0.75, 0.57, 1.00);
	colors[clr.HeaderHovered]          = ImVec4(0.00, 0.94, 0.60, 1.00);
	colors[clr.HeaderActive]           = ImVec4(0.00, 0.71, 0.46, 1.00);
	colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
	colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
	colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
	colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
	colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
	colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
	colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
	colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
	colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end
apply_custom_style()

function imgui.TextQuestion(text)
	imgui.TextDisabled('(?)')
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end
function set_player_skin(id, skin)
	local BS = raknetNewBitStream()
	raknetBitStreamWriteInt32(BS, id)
	raknetBitStreamWriteInt32(BS, skin)
	raknetEmulRpcReceiveBitStream(153, BS)
	raknetDeleteBitStream(BS)
end

