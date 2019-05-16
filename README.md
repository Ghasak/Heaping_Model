# Examine the influencial area of Transit-Oriented Developement: Multimodel Accessbility
This a part of a big project to identify the transit multimodal accessibility.
* Focus on imputed data
Estimating Influence Areas of Each Model:
* Creating Search over time video graphs.
All Details for this project is located in ONENOTE Page under: Building Search Word DataBase Project.
While the file location is at:
* ~/Desktop/My_DATA_MP/Learning/[1] Data_Analysis_Python_Tricks.


## Project Results
We will get a video shows all the words searched in past years in Google Engine.
![](https://github.com/Ghasak/Data_Analysis_Google_Tracking/blob/master/video.gif)


Full Video is available here (You will need VLC-Player):
https://github.com/Ghasak/Data_Analysis_Google_Tracking/blob/master/video.avi



## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.
Then login to the following website from Google:
https://myaccount.google.com/data-and-personalization
and then go to the Data & Personalization.
The you will go to download your data:
Grab them all to know more information that Google collect on you.

## PART -ONE-
We have created two VirtualEnv for each machine we are working and they are:

```
For MacPro     : Ghpylib37Conda
For MacBook Pro: X
```

### Steps
### Make Table
This step is shown in the SQLite DataBase as following:
![](https://github.com/Ghasak/Data_Analysis_Google_Tracking/blob/master/1.png)

### Search Data
list of stop words is located here: in a format of list (English word)
https://gist.github.com/sebleier/554280

### Dynamically inserting into a Database with SQLite.
```
From:
c.execute("INSERT INTO stuffToPlot (unix, datestamp, keyword, value) VALUES (?, ?, ?, ?)",
          (unix, date, keyword, value))
Get:
c.execute("INSERT INTO words (unix, word) VALUES (?,?)", (d,w))
```
https://pythonprogramming.net/sqlite-part-2-dynamically-inserting-database-timestamps/

## PART -TWO-
We will crreate Search over time video graphs -Data Analysis of Google Takeout p.2
the purpose is to develope such algorithm to give us a graph of one year searched words in google engine.
You will need to finish **PART -ONE-** as you will need **mylife.db** DataBase
### Step -1-
We will need to create a directory to export all images that will created located here:
```
cwd+\word_images_1yrwin_1dslide : 1 year window 1 day slide.
```
### Step -2-
Connect to your current DataBase using:
```
conn = sqlite3.connect("mylife.db")
```
this will allow us to navigate our current database in the directory and we can apply our methods to find max or min values. To find max or min you can use
```
c.execute("SELECT max(unix) FROM words")
```
more details on SQLite can be found here: https://docs.python.org/2/library/sqlite3.html


### Step -3-
Using from the standard library (collections- High-performance container datatypes)
More details are located here:
https://docs.python.org/2/library/collections.html
```
Example:
from collections import Counter
A = ['1','1','1','hello','hello','what']
S = Counter(A)
print(S)
Results:
Counter({'1': 3, 'hello': 2, 'what': 1})
```


### Step -4-
Convert the Image files to a video: we will use the following code from
https://www.pythonprogramming.net/deep-dream-video-python-playing-neural-network-tensorflow/



## Folder Protection
the folder Backup has the files that needed to this session.
including the google Takeout and the mylife.db in SQLite.

## Initializing the repository
you will need to perform for bigger folders the following steps.
* initalizing your repository:
```
 git lfs track "*.db" "*.xlsx" "*.csv"
```
* uploading everything to the Staging Area
```
git add . and check with git status
```

## Working Progress ...
Similar to the other configurations, we will add more features to our current python file.
We will create a dynmaic figure that show the words that we googled in the past year.
Adding the DataBase to our SQL-Studio App on MacBook.
![](https://github.com/Ghasak/Data_Analysis_Google_Tracking/blob/master/2.gif)

## Prerequisites
What things you need to install the software and how to install them

```
pip install requirements.txt
```
to see your mylife.db you will need to install SQLite Studio.
## Python Version

I have used Python3.7 Anaconda.
See the results:
![]()
## Authors

* **Ghasak Ibrahim** - *Initial work* -

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
## Acknowledgments
* Hat tip to anyone whose code was used

## Inspiration
following this project from:
* [1] (https://www.youtube.com/watch?v=Siyg1Wn5VDs&list=PLQVvvaa0QuDfWjcDi0GB1AsAuSCAb_JoX&index=1&frags=pl%2Cwn)

## To add some keyboard keys use:
<kbd>Ctrl</kbd>
## Adding more features:
## Requirements
Python 3.x <br />
Packages: see **requirements.txt** <br />
## Instructions
1. Install all required packages
2. Modify parameters if desired
3. Run **folder/script.py**
