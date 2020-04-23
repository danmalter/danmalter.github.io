---
title: "Using AWS Rekognition with R"
layout: post
comments: true
category: R
---
  
  {% raw %}

# Using AWS Rekognition with R #

This post will demonstrate how to use the AWS Rekognition API with R.  In order to do this, I use 
the [paws](https://paws-r.github.io/) R package to interact with AWS.  The output image will label a new, 
unseen image with the name of the individual as well as the emotions tied to the face for that image.


```r
### AWS Face and Emotion recognition ###

library(paws)  # used for AWS configuration
library(magick)  # used for image functions
library(tidyverse)

aws_access_key_id = "################"
aws_secret_access_key = "################"

svc <- rekognition()

### Create an AWS collection (server-side containers) ###
# Create a library of faces used for determining the identity of a new photo

svc$create_collection(CollectionId = "photos-r")
#svc$delete_collection(CollectionId = "photos-r")

# photos stored in directory within folders containing the person name
# i.e. all "Danny" photos are in folder named "Danny"

# Get the list of files
path = "~/Desktop/face_detection/photos"
filenames <- list.files(path, recursive=TRUE)

# Loop through the files in the specified folder, add and index them in the collection
for(f in filenames) {
  imgFile = paste(path,f,sep="/")
  # Get the person name, which is embedded in the last file path folder name
  imgName = unlist(strsplit(f,split="/"))[[1]]
  # Add the photos and the name to the AWS collection
  svc$index_faces(CollectionId="photos-r", Image=list(Bytes=imgFile), ExternalImageId=imgName, DetectionAttributes=list())
}

svc$list_faces(CollectionId = "photos-r")

### Label and identify the face of a new photo ###

# Grab a new photo with multiple faces
group_photo = "~/Desktop/face_detection/img1.JPG"
group_file_name = unlist(strsplit(group_photo,split="/"))[[4]]  # used for writing out annotated file

# Read the photo using magick
img = image_read(group_photo)

# Get basic info about the photo to be used for annotation
inf = image_info(img)

# Detect the faces in the image and pull all attributes associated with faces
o = svc$detect_faces(Image=list(Bytes=group_photo), Attributes="ALL")

# Get the face details
all_faces = o$FaceDetails
length(all_faces)


### For each face in photo, draw a rectange with the name and emotions ###
new.img = img  # Duplicate the original image
people_df <- NULL

for(face in all_faces) {

  # Grab emotions from AWS rekognition model
  emo_label = ""
  for(emo in face$Emotions) {
    emo_label = paste(emo_label, emo$Type, " = ", round(emo$Confidence, 2), "\n", sep="")
  }
  
  # Grab ages from AWS rekognition
  age_label = ""
  for(age in list(face$AgeRange)) {
    age_label = paste(age_label, "AGE ESTIMATE: = ", (age$Low+age$High)/2, "\n", sep="")
  }
  
  # Grab genders from AWS rekognition
  #gender_label = ""
  #for(gndr in list(face$Gender)) {
  #  gender_label = paste(gender_label, gndr$Value, " = ", round(gndr$Confidence, 2), "\n", sep="")
  #}
  
  # Append all lists together
  final_label = ""
  final_label <- rbind(emo_label, age_label)
  final_label <- paste(final_label, collapse = '')
  
  # Identify the coordinates of the face. Note that AWS returns percentage values of the total image size. This is
  # why the image info object above is needed
  box = face$BoundingBox
  image_width=inf$width
  image_height=inf$height
  x1 = box$Left*image_width
  y1 = box$Top*image_height
  x2 = x1 + box$Width*image_width
  y2 = y1 + box$Height*image_height  
  
  # Create a subset image in memory that is just cropped around the focal face
  img.crop = image_crop(img, paste(box$Width*image_width,"x",box$Height*image_height,"+",x1,"+",y1, sep=""))
  img.crop = image_write(img.crop, path = NULL, format = "png")
  
  # Search in a specified collection to see if we can label the identity of the face is in this crop
  o = svc$search_faces_by_image(CollectionId="photos-r",Image=list(Bytes=img.crop), FaceMatchThreshold=70)
  
  # Create a graphics device version of the larger photo that we can annotate
  new.img = image_draw(new.img)
  
  # If the face matches something in the collection, then add the name to the image
  if(length(o$FaceMatches) > 0) {
    faceName = o$FaceMatches[[1]]$Face$ExternalImageId
    faceConfidence = round(o$FaceMatches[[1]]$Face$Confidence,3)
    print(paste("Detected: ", faceName, sep=""))
    
    # Annotate with the name of the person
    text(x=x1+(box$Width*image_width)/2, y=y1-20, faceName, adj=0.5, cex=3, col="green")
  }
  
  # Draw a rectangle around the face
  rect(x1,y1,x2,y2, border="red", lty="dashed", lwd=5)   
  
  # Annotate the photo with the emotions information
  text(x=x1+(box$Width*image_width)/2, y=y1+50, final_label, pos=1, cex=1.5, col="red")     
  
  # Create a dataframe of individual data appended together
  individual_emotion_df <- do.call(rbind.data.frame, face$Emotions)
  
  individual_emotion_df <- individual_emotion_df %>% 
    spread(Type, Confidence) %>%
    add_column(faceName) %>%
    select(faceName, everything()) # move faceName to beginning
  
  individual_age_df <- data.frame(face$AgeRange)
  colnames(individual_age_df) <- c("age_low", "age_high")
  
  individual_df <- cbind(individual_emotion_df, individual_age_df)
  
  people_df <- rbind(individual_df, people_df)
  
}
dev.off()

people_df$age_est <- (people_df$age_low + people_df$age_high)/2
head(people_df)

# Write the image out to file 
image_write(new.img, path=paste0("~/Desktop/face_detection/annotated/annotated_", group_file_name))
```

```
| faceName | angry      | calm        | confused   | disgusted   | fear        | happy    | sad         | surprised  |
|----------|------------|-------------|------------|-------------|-------------|----------|-------------|------------|
| Natalie  | 0.05724448 | 0.008161878 | 0.08076324 | 0.054936308 | 0.048346419 | 99.64977 | 0.037308376 | 0.06347576 |
| Danny    | 0.01850546 | 0.008797654 | 0.01369155 | 0.005110143 | 0.009048435 | 99.88663 | 0.003529715 | 0.05468611 |
```

![face-detection](/figure/2020-04-23-aws-rekognition/annotated_image.JPG)


{% endraw %}

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-57468410-2', 'auto');
  ga('send', 'pageview');

</script>

