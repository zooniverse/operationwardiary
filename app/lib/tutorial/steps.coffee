{Step} = require 'zootorial'

module.exports =
  id: "diaries-tut"
  firstStep: "welcome"
  length: 13
  steps:    
    welcome: new Step
      number: 1
      header: "Welcome to Operation War Diaries!"
      details: "This short tutorial will walk you through the tagging process. Let&#039;s get started!" 
      attachment: "center center .viewport center center"
      next: "intro"

    intro: new Step
      number: 2
      header: "Check out the diaries"
      details: "There are around 1.5 million pages of unit war diaries. Half of them are standard diary pages, like this one, but there are also lots of other types of pages. We need your help to classify the page types and then tag the data on that page. "
      attachment: "center center .viewport center center"
      next: "choose"
    
    choose: new Step
      number: 3
      header: "Select a diary to work on"
      details: "You&#039;ll be given a sequence of pages from a diary &ndash; if you&#039;d rather work on a different diary to the one you&#039;re given, select another from the drop-down list at the bottom of the screen."
      attachment: "center center .viewport center center"
      next: "page_type"
    
    page_type: new Step
      number: 4
      header: "Classifying diary pages"
      details: "Around half of the pages are diary pages, like the one shown here. Most use a pre-printed template, although some may be free-form. You&#039;ll also notice that some are handwritten while others have been typed. Select <b>Diary page</b> from the toolbar to classify the page."
      instruction: "Click <b>Diary page</b>"
      attachment: "left top .tools right top"
      next:
        "click label[for=document-diary]": "get_tagging"
    
    get_tagging: new Step
      number: 5
      header: "Get tagging"
      details: "Now that you&#039;ve decided what type of page it is, it&#039;s time to start tagging!"
      attachment: "center center .viewport center center"
      next: "tagging_intro"
    
    tagging_intro: new Step
      number: 6
      header: "Tagging the data in diary pages"
      details: "Diary pages are laid out in a standard four-column format. The first three columns list place, date and hour, while the fourth column contains the narrative account of operations. <br><br>The fourth column could contain lots of different information, including people, activities and references to other pages within the diaries (including maps)."
      next: "tag_places"
    
    tag_places: new Step
      number: 7
      header: "Tagging places"
      details: "Click the <b>Place</b> tag, then click again on the diary page to attach it to where a place is listed. The pop-up box will ask you to enter the place name, and the map will centre on that place."
      instruction: "Click the <b>Place</b> tag."
      attachment: "left center label[for='category-place'] right center"
      next: 
        "click label[for=category-place]": "tag_dates"
    
    tag_dates: new Step
      number: 8
      header: "Tagging dates and times"
      details: "Dates and times are even simpler &ndash; when you attach them to the diary page you&#039;ll get a calendar tool and drop-down boxes to select from."
      attachment: "left center label[for='category-diaryDate'] right center"
      instruction: "Click the <b>Date</b> tag."
      next: 
        "click label[for=category-diaryDate]": "tag_people"
    
    tag_people: new Step
      number: 9
      header: "Tagging people"
      details: "People are also easy to tag &ndash; click on the toolbar on the left of the screen, then again on the diary page to attach the tag. You&#039;ll then be asked to fill in as much detail as you can about that individual, including their rank and regimental number if given."
      attachment: "left center label[for='category-person'] right center"
      instruction: "Click the <b>Person</b> tag."
      next: 
        "click label[for=category-person]": "tag_other"
    
    tag_other: new Step
      number: 10
      header: "Tagging other information"
      details: "You may well find other important pieces of information in the fourth column, such as what the unit was doing or what the weather was like. Choose and apply the other tags in the menu/toolbar whenever you find this type of information listed."
      attachment: "left center label[for='category-activity'] right center"
      instruction: "Click the <b>Unit activity</b> tag."
      next: 
        "click label[for=category-activity]":"tag_pages"
    
    tag_pages: new Step
      number: 11
      header: "Classifying other page types"
      details: "As well as diary pages, you may come across some more unusual pages like this one. If you&#039;re unsure of the different page types you can view typical examples through the <a href='#/guide'>Field Guide</a>.<br><br>The list of available tags may change depending on the type of page that you&#039;re looking at."
      next: "timeline"
      
    timeline: new Step
      number: 12
      header: "Editing or deleting tags"
      details: "Before you finish a page, you can review your tags to make sure that you&#039;re happy with them. Click on the <b>timeline</b> icon on the top right of the screen to see all the tags that you&#039;ve attached to this image &ndash; you can then click on individual tags to edit or delete them."
      attachment: "center top button.timeline center bottom"
      instruction: "Click the <img src='images/icons/timeline.png' alt='timeline'> button."
      next: 
        "click button.timeline":"finished"
      
    finished: new Step
      number: 13
      header: "Finished"
      details: "Once you&#039;re happy that you&#039;ve tagged as much as you can, click Finished to submit this page and your tags."