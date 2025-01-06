<div align="center">

# New
</div>

# what is new?
New is simple **powershell** script that  
simplify file/folder creation  

inspired from linux **touch** command  

# how to use
## Useage
> new folder <**foldername**> [-flags]  

> new file <**filename**> [-flags]  
## Examples
> new folder foo  

this will create a folder called foo :)  

> new folder bar -git -code  

this will create folder called bar and initilize git repo and open vscode at once  

> new file index.js -code -overwrite  

this will create js file and open it in vscode  
overwrite flag with force overwrite the file  

> new folder  

# why ?
why not ? :3  

you make things more fast  

# flags
## Folder
| Flag | description |  
|----- | -------------|  
|cd | will cd into the folder |  
|code | open the folder in vscode |  
|git | initialize git repository |  
|overwrite | will force overwrite the folder |  
|h| to show help message |  

## File
| Flag | description |  
|----- | -------------|  
|code | open the file in vscode |  
|overwrite | will force overwrite the file |  
|h| to show help message |
