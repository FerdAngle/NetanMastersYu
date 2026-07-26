> [!CAUTION]
> I'm **NOT** hosting on any other site. The only official place to download NetanMastersYu is this repository.
>
<div align="center">
<picture> 
  <img src="https://raw.githubusercontent.com/FerdAngle/.github/main/assets/logos/MacroLogo.png">
</picture>


[![][latest-release-shield]][latest-release-link]
[![][downloads-shield]][downloads-link]
<br>
The open source form mastery project.
</div>

<a name="Prerequisites"><h2>🔨 Prerequisites </h2></a>

1. ProcessExplorer https://learn.microsoft.com/en-us/sysinternals/downloads/process-explorer
2. RDPWrapper (optional, for people who want to macro in the background whilst still wanting to use their PC)

<a name="installation"><h2>⬇️ Installation</h2></a>

1. Download NetanMastersYu v#.#.#.zip from the [latest release][latest-release-link]
2. Open NetanMastersYu _v#.#.# and double-click the folder inside
3. Run MASTERSTART.bat and wait for the macro to load

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

**Note:** if you're not interested in farming mastery via an alt, and just want to transoform/detransform loop, then read the section below.

<a name="more info"><h2>ℹ️ FAQ + Macro Config Setups:</h2></a>

**Combat time only:** Set Transformation Phase to "Before TP" | Have a user in the TP User field. <br>
**Combat zenkai:** Set Transformation Phase to "After TP" | Have a user in the TP User field. <br>
**Transformation/detransformation loop only:** Set Transformation Phase to "Before TP" | Blank out the TP User field

**Q:** As a frieza, I remain in form after death, how will I be affected?? <br>
**A:** 💀🤞 Unfortunately, mastery will just be 2x slower for friezas since they'll need to detransform during the macro process. However, I'll try to find a workaround for this in the future (since I MAIN the race)

**Q:** How do I farm FSSJ mastery? <br>
**A:** Just set your transformation key to "None" (whilst having your setting set to "After TP" and an alt to TP to) 

**Q:** How do I get/use RDPWrapper? <br>
**A:** Watch a tutorial online for a setup (I personally recommend this up to the 5:10 mark https://www.youtube.com/watch?v=4Oexj5zf84I&t=45s) and then afterwards, try to always update your rdpwrap.ini file from the issues tab of the [official creators repository][rdp-wrap-link] 

[latest-release-shield]: https://img.shields.io/github/v/release/FerdAngle/NetanMastersYu?logo=github&logoColor=white&labelColor=black&color=faa125
[latest-release-link]: https://github.com/FerdAngle/NetanMastersYu/releases/latest

[downloads-shield]: https://img.shields.io/github/downloads/FerdAngle/NetanMastersYu/total?label=downloads&labelColor=black&color=40ca53
[downloads-link]: https://github.com/FerdAngle/NetanMastersYu/releases

[rdp-wrap-link]: https://github.com/stascorp/rdpwrap/issues


