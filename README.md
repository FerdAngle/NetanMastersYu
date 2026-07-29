> [!CAUTION]
> I'm **NOT** hosting on any other site. The only official place to download NetanMastersYu is this repository.
>
<div align="center">
<picture> 
  <img src="https://raw.githubusercontent.com/FerdAngle/.github/main/assets/logos/MacroLogo.png">
</picture>
<br>

[![][latest-release-shield]][latest-release-link]
[![][downloads-shield]][downloads-link]
<br>
The open source form mastery project that reaches for the red star.
</div>

<a name="Prerequisites"><h2>🛠️ Prerequisites </h2></a>

1. ProcessExplorer https://learn.microsoft.com/en-us/sysinternals/downloads/process-explorer
2. RDPWrapper (optional, for people who want to macro in the background while still wanting to use their PC)

<a name="installation"><h2>⬇️ Installation</h2></a>

1. Download NetanMastersYu-v#.#.#.zip from the [latest release (click here)][latest-release-link]
2. Right click on the file and extract the file
3. Open the extracted file and and click on StartMacro.bat to open the macro. 

<a name="installation"><h2>❔ Tutorial (for setting up two accounts to work with the macro) </h2></a>

1) Open DBZ Final Stand: Remastered on your ALT account FIRST (the account that will be m1ing your main) and press Win + RightArrowKey to split your screen with your ALT account on the right handside.  

2) Next, run process explorer as administrator and then type "roblox" in the top right search field and afterwards enable the Handles panel found near the top left (or enable it via CTRL + L) 
<div align="center">
<picture> 
  <img src="https://raw.githubusercontent.com/FerdAngle/.github/main/assets/processExplorerSS/HandleFindRblxSS.png">
</picture>
</div>

2.b) Click on RobloxPlayerBeta.exe and double check you're on the "Handles" section of the panel below. Then find the event that dislays "ROBLOX_singletonEvent" and right click on the even and click "Close Handle". 
<div align="center">
<picture> 
  <img src="https://raw.githubusercontent.com/FerdAngle/.github/main/assets/processExplorerSS/SingletonSS.png">
</picture>
</div>

3) After closing the Singleton event, you should then launch your main account **whilst** keeping your ALT account open ingame, split screening it like your ALT's roblox window but this time positioning it to the left side of your screen. Once your main account is on the main menu of FSR, hover your cursor over the slot that you want to farm mastery on and press your binded "Add slot" hotkey (open the macro beforehand) Then click on the slot and find what server your ALT account belongs to. 

4) With both accounts launched and in the same server, find a confined space where your ALT can reach your main with m1s but where your main cannot escape out of range. Ideally, one should just dig a hole in the ground and carve out a cube like area (recommended to dig with ki blasts and then crusher ball to create tiny spaces) 

5) Once you have secured a hole or some other very confined space, go back to your alt roblox window and place it inside of the space and then hold down LMB (Left-mouse button) and whilst holding it down, press esc on your keyboard and your alt should continue to m1 without you having to hold down the mouse.  

6) After your alt has been fully setup, go back to your main roblox window and then start the macro (ensuring your settings are properly configured on the macro beforehand) and enjoy farming form mastery ig.

**Note:** if you're not interested in farming mastery via an alt, and just want to transform/detransform loop, then read the section below.

<a name="more info"><h2>ℹ️ FAQ + Macro Config Setups:</h2></a>

**Combat time only:** Set Transformation Phase to "Before TP" | Have a user in the TP User field. <br>
**Combat zenkai:** Set Transformation Phase to "After TP" | Have a user in the TP User field. <br>
**Transformation/detransformation loop only:** Set Transformation Phase to "Before TP" | Blank out the TP User field

**Q:** How do I add forms/slots? <br>
**A:** Hover your cursor where your form/slot is on your SPLIT screen view of roblox, and press your binded key related to it to save the coordinates of its position. 

**Q:** How do I delete or rename forms/slots? <br> 
**A:** Right click on the form/slot that is selected in the rectangular field and the options will show. 

**Q:** As a frieza, I remain in form after death, how will I be affected?? <br>
**A:** 💀🤞 Unfortunately, mastery will just be 2x slower for friezas since they'll need to detransform during the macro process. However, I'll try to find a workaround for this in the future (since I MAIN the race)

**Q:** How do I farm FSSJ mastery? <br>
**A:** Just set your transformation key to "None" (whilst having your setting set to "After TP" and an alt to TP to) 

**Q:** How do I get/use RDPWrapper? <br>
**A:** Watch a tutorial online for a setup (I personally recommend this up to the 5:10 mark https://www.youtube.com/watch?v=4Oexj5zf84I&t=45s) and then afterwards, try to always update your rdpwrap.ini file from the issues tab of the [official creators repository][rdp-wrap-link] 

<a name="more info"><h2>💚 Credits</h2></a>

ME, MYSELF AND I.

In all seriousness, I was inspired to start on this project due to being a longtime user of natro macro & a BSS fan; so when I came to FSR I wondered "what annoying thing exists that takes a longtime to do but is possible to automate?" and thus here we are...In fact, a lot of what you see on this webpage is inspired by the design of natro macro's repo. 
Although, can't quite say the same for the code though since I decided to start off with AHKv1 instead of AHKv2 💔

@FerdAngle  <br>
...also to [REDACTED]Worl for giving me enough time to decide on whether or not I wanted to make this 🙏

[latest-release-shield]: https://img.shields.io/github/v/release/FerdAngle/NetanMastersYu?logo=github&logoColor=white&labelColor=black&color=faa125
[latest-release-link]: https://github.com/FerdAngle/NetanMastersYu/releases/latest

[downloads-shield]: https://img.shields.io/github/downloads/FerdAngle/NetanMastersYu/total?label=downloads&labelColor=black&color=40ca53&logo=data:image/svg%2bxml;base64,PHN2ZwogICB2aWV3Qm94PSIwIDAgMjQgMjQiCiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgPHBhdGgKICAgICBmaWxsPSIjZmZmIgogICAgIGQ9Ik0gMTIsMC4yMDk2MTUxNSBBIDExLjc5MDM4NSwxMS43OTAzODUgMCAxIDAgMjMuNzkwMzg1LDEyIDExLjc5MDM4NSwxMS43OTAzODUgMCAwIDAgMTIsMC4yMDk2MTUxNSBaIE0gOS4zMDAwMDE5LDkuOTgzODQ0MiAxMC44MjA5NjIsMTEuNTE2NTk0IFYgNC45MjU3NjkxIGggMi4zNTgwNzYgViAxMS41MTY1OTQgTCAxNC42OTk5OTgsOS45OTU2MzQ2IDE2LjM2MjQ0MiwxMS42NTgwNzkgMTIsMTYuMDIwNTIxIDcuNjI1NzY3MiwxMS42NTgwNzkgWiBNIDE2LjcxNjE1NCwxOS4wNzQyMzEgSCA3LjI4Mzg0NjEgdiAtMi4zNTgwNzcgaCA5LjQzMjMwNzkgeiIKICAgICAvPgo8L3N2Zz4K
[downloads-link]: https://github.com/FerdAngle/NetanMastersYu/releases

[rdp-wrap-link]: https://github.com/stascorp/rdpwrap/issues



