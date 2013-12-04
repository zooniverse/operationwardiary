{Step} = require 'zootorial'
Route = require 'spine/lib/route'

module.exports =
  id: "diaries-tut"
  firstStep: "welcome"
  steps:    
    length: 17
    welcome: new Step
      number: 1
      header: "Welcome to Operation War Diary"
      details: "<p>This short tutorial will walk you through the tagging process. Let&#039;s get started!</p>" 
      attachment: "center center .subject-container center center"
      next: "intro"

    intro: new Step
      number: 2
      header: "Check out the diaries"
      details: "<p>There are around 1.5 million pages of unit war diaries that cover activity on the Western Front. There are lots of different types of page full of fascinating details about the people involved and descriptions of what they were doing. </p>
<p>We need your help to classify the type of page and then tag the data.</p> "
      attachment: "center center .subject-container center center"
      next: "page_type"
    
    page_type: new Step
      number: 3
      header: "Classifying diary pages"
      details: "<p>Choose the classification that best matches the page you can see. If you are not sure which one to choose you can see examples in the Field Guide.</p>
<p>Around half of the pages are standard diary pages, like this one.</p> 
<p>Select <b>Diary page</b> from the menu on the left of the screen to classify the page.</p>"
      instruction: "Click <b>Diary page</b>"
      attachment: "left center label[for='document-diary'] right center"
      focus: "label[for='document-diary']"
      next:
        "click label[for=document-diary]": "get_tagging"
    
    get_tagging: new Step
      number: 4
      header: "Get tagging"
      details: "<p>Now that you&#039;ve decided what type of page it is, it&#039;s time to start tagging!</p>
<p>Different page types are likely to contain different types of information so the list of available tags will change depending on the type of page you&#039;ve selected.</p>"
      attachment: "center center .subject-container center center"
      next: "tagging_intro"
    
    tagging_intro: new Step
      number: 5
      header: "Tagging the diary pages"
      details: "<p>Most Diary pages use a pre-printed template although some may be written on note paper. They can be either typed or handwritten.</p>
<p>The form is a standard five-column format. The first three columns list place, date and hour. The fourth column contains the narrative account of operations and can contain lots of different information about people and activities. </p>
<p>References to other documents within the diaries including maps and reports are recorded in the fifth column.</p>"
      attachment: "center center .subject-container center center"
      next: "tag_dates"
      
    tag_dates: new Step
      number: 6
      header: "Tagging dates and times"
      details: "<p>Start tagging by working your way down the Date column. This will divide the page into horizontal sections based on the date. Any other tags you place will then be associated with that date so we can create a timeline of activity.</p>
<p>Select Date from the tag menu on the left of the screen.</p>"
      attachment: "left center label[for='category-diaryDate'] right center"
      instruction: "Click the <b>Date</b> tag."
      focus: "label[for=category-diaryDate]"
      next: 
        "click label[for=category-diaryDate]": "add_dates"
    
    add_dates: new Step
      number: 7
      header: "Adding a date"
      className: "point-left"
      details: "<p>You can see that there were a number of entries at different times during 20 May.</p>
<p>Click on the first entry and choose 20 May from the calendar tool. You should see a horizontal line appear above the entry. Click on the tick box to confirm.</p>"
      attachment: "left middle .subject-container .20 .41"
      instruction: "Add <b>20 May 1915</b> above the entry"
      next: 
        "click button[name=toggle]": "second_date"
    
    second_date: new Step
      number: 8
      header: "Adding a second date"
      className: "point-left"
      details: "<p>Now do the same thing for the next date, 21 May, and a second line will appear, dividing the entries into sections.</p>
<p>When you are happy you have recorded the correct information click on the tick box to complete the tag.</p>"
      attachment: "left middle .subject-container .20 .80"
      instruction: "Add <b>21 May 1915</b> above the entry"
      next: 
        "click button[name=toggle]": "tag_places"
    
    tag_places: new Step
      number: 9
      header: "Tagging places"
      details: "<p>Once you have tagged all the dates follow the same approach for Places.</p>
<p>Select the <b>Place</b> tag in the tag menu.</p>"
      instruction: "Click the <b>Place</b> tag."
      attachment: "left center label[for='category-place'] right center"
      focus: "label[for='category-place']"
      next: 
        "click label[for=category-place]": "add_places"
    
    add_places: new Step
      number: 10
      header: "Choosing a place"
      className: "point-left"
      details: "<p>Click on the second entry for 20 May where it says ‘Aldershot’ to attach the tag. Try to make sure that you click within the horizontal lines for the relevant date.</p>
<p>In the pop-up box enter 'Aldershot', and the map will centre on that place.</p>
<p>If you make a mistake you can delete the tag by clicking on the X box or tick to complete the tag.</p>"
      attachment: "left middle .subject-container .13 .50"
      instruction: "Add <b>Aldershot</b>"
      next: 
        "click button[name=toggle]": "tag_people"
    
    tag_people: new Step
      number: 11
      header: "Tagging people"
      details: "<p>Once you have completed all the dates, places and times look at the fourth column for any mention of people and activities.</p> 

<p>Can you see an individual mentioned by name on this page? <b>Sergeant Byrne</b> became a casualty on 21 May. Select Person in the tag menu, then click on the diary page by his name to attach the tag.</p>"
      attachment: "left center label[for='category-person'] right center"
      instruction: "Click the <b>Person</b> tag."
      focus: "label[for='category-person']"
      next: 
        "click label[for=category-person]": "add_people"
        
    
    add_people: new Step
      number: 12
      header: "Tell us why they were mentioned"
      className: "point-left"
      details: "<p>Then fill in as much detail about the individual as you can see on the page, including their rank and regimental number if given.</p> 
<p>Choose a <b>Reason</b> from the drop down list that explains why they are mentioned. The Adjutant has stated that Sgt Byrne was a Casualty so choose the closest match – Casualty:Wounded</p>
<p>Click the tick box to complete the tag.</p>"
      attachment: "left middle .subject-container .45 .85"
      instruction: "Add <b>Sgt Byrne</b>"
      next: 
        "click button[name=toggle]": "tag_other"
    
    tag_other: new Step
      number: 13
      header: "Tagging other information"
      details: "<p>You may well find other important pieces of information such as what the unit was doing or what the weather was like.</p>

<p>Remember you can always have a look through the Field Guide if you are not sure what a military phrase means or if it is something that you should tag.</p>

<p>On this diary page there is a description of the Battalion embarking on the SS Victoria so select the <b>Unit Activity</b> tag in the tag menu.</p>"
      attachment: "left center label[for='category-activity'] right center"
      instruction: "Click the <b>Unit Activity</b> tag."
      focus: "label[for='category-activity']"
      next: 
        "click label[for=category-activity]":"add_activity"
    
    add_activity: new Step
      number: 14
      header: "Unit Activity"
      className: "point-left"
      details: "<p>Place the tag on the page where it says ’Embarked’ and then choose an entry from the drop down list that most closely matches the action described in the diary – in this case <b>Unit Movement</b></p>
<p>If you can&#039;t find a relevant description have a look at the <b>Army Life</b> tag list which includes domestic activities, religion, sport and food.</p>
<p>Click the tick box to complete the tag.</p>"
      attachment: "left middle .subject-container .50 .74"
      instruction: "Add <b>Unit movement</b>"
      next: 
        "click button[name=toggle]": "timeline"
      
    timeline: new Step
      number: 15
      header: "Editing or deleting tags"
      details: "<p>Before you finish a page, you can review your tags to make sure that you&#039;re happy with them.</p> 
      <p>Click on the <b>timeline</b> icon to see all the tags that you&#039;ve attached to this image &ndash; you can then click on individual tags to move, edit or delete them.</p>"
      attachment: "center top button.timeline center bottom"
      instruction: "Click the <img src='images/icons/timeline.png' alt='timeline'> button."
      focus: "button.timeline"
      next: 
        "click button.timeline":"finished"
      
    finished: new Step
      number: 16
      header: "Finished"
      details: "<p>Once you&#039;re happy that you&#039;ve tagged as much as you can, click <b>Finished</b> to submit this page and your tags.</p>"
      attachment: "right top button.finish center bottom"
      next: "choose"
      
    choose: new Step
      number: 17
      header: "What happens next"
      details: "<p>Well done! You have successfully completed the tutorial.</p>
<p>Now you can start classifying and tagging. Choose from the list of diaries and get started.</p>"
      attachment: "center center .subject-container center center"
      onExit: -> Route.navigate '/groups'