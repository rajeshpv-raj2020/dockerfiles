```bash
# build
cd ~/projects/github/sense-workspace/workspace/java/BrowseHere
javac org/*.java

# test application
java -cp . org.BrowseHere

# build executable jar
jar -cvfm BrowseHere.jar Manifest.txt org/*.class
jar tf BrowseHere.jar 

# test as flat jar
 java -jar ./BrowseHere.jar 3030 ~/tmp
```