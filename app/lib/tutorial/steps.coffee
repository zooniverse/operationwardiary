{Step} = require 'zootorial'
Spine = require 'spine'
Route = require 'spine/lib/route'
translate = require 't7e'

module.exports =
  id: "diaries-tut"
  firstStep: "welcome"
  steps:    
    length: 10
    welcome: new Step
      number: 1
      header: translate 'tutorial.welcome.header'
      details: translate 'tutorial.welcome.details'
      nextButton: translate 'tutorial.welcome.instruction'
      next: "intro"

    intro: new Step
      number: 1
      header: translate 'tutorial.intro.header'
      details: translate 'tutorial.intro.details'
      next: "about"
    
    about: new Step
      number: 1
      header: translate 'tutorial.about.header'
      details: translate 'tutorial.about.details'
      nextButton: translate "tutorial.about.instruction"
      next: "page_type"
    
    page_type: new Step
      number: 2
      header: translate 'tutorial.page_type.header'
      details: translate 'tutorial.page_type.details'
      instruction: translate 'tutorial.page_type.instruction'
      attachment: "left center label[for='document-diary'] right center"
      focus: "label[for='document-diary']"
      next:
        "click label[for=document-diary]": "get_tagging"
    
    get_tagging: new Step
      number: 2
      header: translate 'tutorial.get_tagging.header'
      details: translate 'tutorial.get_tagging.details'
      next: "tagging_intro"
    
    tagging_intro: new Step
      number: 2
      header: translate 'tutorial.tagging_intro.header'
      details: translate 'tutorial.tagging_intro.details'
      next: "tag_dates"
      
    tag_dates: new Step
      number: 3
      header: translate 'tutorial.tag_dates.header'
      details: translate 'tutorial.tag_dates.details'
      attachment: "left middle label[for='category-diaryDate'] right middle"
      instruction: translate 'tutorial.tag_dates.instruction'
      focus: "label[for=category-diaryDate]"
      next: 
        "click label[for=category-diaryDate]": "add_dates"
    
    add_dates: new Step
      number: 3
      header: translate 'tutorial.add_dates.header'
      className: "point-left"
      details: translate 'tutorial.add_dates.details'
      attachment: "left middle .subject-container .20 .41"
      instruction: translate 'tutorial.add_dates.instruction'
      next: 
        "click button[name=toggle]": "second_date"
    
    second_date: new Step
      number: 3
      header: translate 'tutorial.second_date.header'
      className: "point-left"
      details: translate 'tutorial.second_date.details'
      attachment: "left middle .subject-container .20 .80"
      instruction: translate 'tutorial.second_date.instruction'
      next: 
        "click button[name=toggle]": "tag_places"
    
    tag_places: new Step
      number: 4
      header: translate 'tutorial.tag_places.header'
      details: translate 'tutorial.tag_places.details'
      instruction: translate 'tutorial.tag_places.instruction'
      attachment: "left middle label[for='category-place'] right middle"
      focus: "label[for='category-place']"
      next: 
        "click label[for=category-place]": "add_places"
    
    add_places: new Step
      number: 4
      header: translate 'tutorial.add_places.header'
      className: "point-left"
      details: translate 'tutorial.add_places.details'
      attachment: "left middle .subject-container .13 .50"
      instruction: translate 'tutorial.add_places.instruction'
      next: 
        "click button[name=toggle]": "tag_people"
    
    tag_people: new Step
      number: 5
      header: translate 'tutorial.tag_people.header'
      details: translate 'tutorial.tag_people.details'
      attachment: "left middle label[for='category-person'] right middle"
      instruction: translate 'tutorial.tag_people.instruction'
      focus: "label[for='category-person']"
      next: 
        "click label[for=category-person]": "add_people"
        
    
    add_people: new Step
      number: 5
      header: translate 'tutorial.add_people.header'
      className: "point-left"
      details: translate 'tutorial.add_people.details'
      attachment: "left middle .subject-container .45 .85"
      instruction: translate 'tutorial.add_people.instruction'
      next: 
        "click button[name=toggle]": "tag_other"
    
    tag_other: new Step
      number: 6
      header: translate 'tutorial.tag_other.header'
      details: translate 'tutorial.tag_other.details'
      attachment: "left middle label[for='category-activity'] right middle"
      instruction: translate 'tutorial.tag_other.instruction'
      focus: "label[for='category-activity']"
      next: 
        "click label[for=category-activity]":"add_activity"
    
    add_activity: new Step
      number: 6
      header: translate 'tutorial.add_activity.header'
      className: "point-left"
      details: translate 'tutorial.add_activity.details'
      attachment: "left middle .subject-container .50 .74"
      instruction: translate 'tutorial.add_activity.instruction'
      next: 
        "click button[name=toggle]": "timeline"
      
    timeline: new Step
      number: 7
      header: translate 'tutorial.timeline.header'
      details: translate 'tutorial.timeline.details'
      attachment: "right top button.timeline center bottom"
      instruction: translate 'tutorial.timeline.instruction'
      focus: 'button.timeline'
      next: 
        "click button.timeline":"timeline2"
    
    timeline2: new Step
      number: 7
      header: translate 'tutorial.timeline.header'
      details: translate 'tutorial.timeline.details'
      attachment: "right middle .subject-timeline left middle"
      instruction: translate 'tutorial.timeline.instruction'
      focus: 'button.timeline'
      next: 
        "click button.timeline":"talk"
    
    talk: new Step
      number: 8
      header: translate 'tutorial.talk.header'
      details: translate 'tutorial.talk.details'
      attachment: "right top button.discuss center bottom"
      instruction: translate 'tutorial.talk.instruction'
      focus: 'button.discuss'
      next: 
        "click button.discuss":"talk2"
      
    talk2: new Step
      number: 8
      header: translate 'tutorial.talk.header'
      details: translate 'tutorial.talk.details'
      attachment: "right middle .subject-comments left middle"
      instruction: translate 'tutorial.talk.instruction'
      focus: 'button.discuss'
      next: 
        "click button.discuss":"finished"
      
    finished: new Step
      number: 9
      header: translate 'tutorial.finished.header'
      details: translate 'tutorial.finished.details'
      instruction: translate 'tutorial.finished.instruction'
      attachment: "right top button.finish center bottom"
      focus: 'button.finish'
      next: "click button.finish":"profile"
    
    profile: new Step
      number: 9
      header: translate 'tutorial.profile.header'
      details: translate 'tutorial.profile.details'
      next: "choose"
      onEnter: ->
        Route.navigate '/profile'
      
    choose: new Step
      number: 10
      header: translate 'tutorial.choose.header'
      details: translate 'tutorial.choose.details'
      nextButton: translate 'tutorial.choose.instruction'
      attachment: 'right top .zooniverse-top-bar center bottom'
      focus: '.zooniverse-top-bar'
      onEnter: ->
        Route.navigate '/diaries'
      onExit: ->
        Spine.trigger 'tutorial:done'