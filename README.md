THIS SCRIPT IS DEPRECATED. KICAD 9 HAS A "SAVE AS" FEATURE UNDER "FILE" WHICH DOES THE SAME THING AS THIS SCRIPT--USE THAT.

# Create_new_KicadProject_fromExisting
Powershell script to automate making new Kicad projects out of existing ones.
Unlike Eagle, Kicad has a one project/one PCB limit.
I often want to clone an existing project without having to resort to version control.
This has meant copying the old project folder, renaming the new folder, cleaning out unneeded files in the new folder, and renaming the new files in the new folder to match the name of the new project.

This Powershell script:

--Asks you to select an initial project folder using a Windows Form.

--Asks you to give the new project folder a name.

--Creates a new project folder and copies all files from new to old

--Deletes all file dreck from new project folder except *.kicad_sch, *.kicad_pro, *.kicad_brd, and *.wks files

--Deletes the *-backups subfolder in the newly created project

--renames all files in the new project directory with the name of the new project, but leaves extensions names intact.

The script is a bit rough, for instance, you have to X out of the copy form to get the script to keep chuffing, but, hey, it works.

You will need a relatively recent version of Powershell or VSCODE with Powershell extensions, etc., installed on your Window$ system to make this go.

More info: see this blog post. https://audiodiwhy.blogspot.com/2023/09/kicad-making-switch.html
