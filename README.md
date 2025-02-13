# Create_new_KicadProject_fromExisting
Powershell script to automate making new Kicad projects out of existing ones.
Unlike Eagle, Kicad has a one project/one PCB limit.
I often want to clone an existing project and create an entirely new one, without having to resort to version control.
This has meant copying the old project folder, renaming the new folder, cleaning out unneeded files in the new folder, and renaming the new files in the new folder to match the name of the new project.

This Powershell script:
--Asks you to select an initial project folder.

--Asks you to give the new project folder a name.

--Copies all files from new to old

--Deletes all dreck from new project folder except *.kicad_sch, *.kicad_pro, *.kicad_brd, and *.wks

--renames all files in the new directory with the name of the directory, but leaves extensions names intact.

More info: see this blog post. https://audiodiwhy.blogspot.com/2023/09/kicad-making-switch.html
