{Step} = require 'zootorial'
Spine = require 'spine'
Route = require 'spine/lib/route'
translate = require 't7e'

get_text = (key) =>
  el = translate 'div', key, raw: true
  el.innerHTML

module.exports =
  id: "diaries-tut"
  firstStep: "welcome"
  steps:    
    length: 10
    welcome: new Step
      number: 1
      header: get_text 'tutorial.welcome.header'
      details: get_text 'tutorial.welcome.details'
      attachment: "center center .subject-container center center"
      next: "intro"

    intro: new Step
      number: 1
      header: get_text 'tutorial.intro.header'
      details: get_text 'tutorial.intro.details'
      attachment: "center center .subject-container center center"
      next: "about"
    
    about: new Step
      number: 1
      header: get_text 'tutorial.about.header'
      details: get_text 'tutorial.about.details'
      nextButton: get_text "tutorial.about.instruction"
      attachment: "center center .subject-container center center"
      next: "page_type"
    
    page_type: new Step
      number: 2
      header: get_text 'tutorial.page_type.header'
      details: get_text 'tutorial.page_type.details'
      instruction: get_text 'tutorial.page_type.instruction'
      attachment: "left center label[for='document-diary'] right center"
      focus: "label[for='document-diary']"
      next:
        "click label[for=document-diary]": "get_tagging"
    
    get_tagging: new Step
      number: 2
      header: get_text 'tutorial.get_tagging.header'
      details: get_text 'tutorial.get_tagging.details'
      attachment: "center center .subject-container center center"
      next: "tagging_intro"
    
    tagging_intro: new Step
      number: 2
      header: get_text 'tutorial.tagging_intro.header'
      details: get_text 'tutorial.tagging_intro.details'
      attachment: "center center .subject-container center center"
      next: "tag_dates"
      
    tag_dates: new Step
      number: 3
      header: get_text 'tutorial.tag_dates.header'
      details: get_text 'tutorial.tag_dates.details'
      attachment: "left center label[for='category-diaryDate'] right center"
      instruction: get_text 'tutorial.tag_dates.instruction'
      focus: "label[for=category-diaryDate]"
      next: 
        "click label[for=category-diaryDate]": "add_dates"
    
    add_dates: new Step
      number: 3
      header: get_text 'tutorial.add_dates.header'
      className: "point-left"
      details: get_text 'tutorial.add_dates.details'
      attachment: "left middle .subject-container .20 .41"
      instruction: get_text 'tutorial.add_dates.instruction'
      next: 
        "click button[name=toggle]": "second_date"
    
    second_date: new Step
      number: 3
      header: get_text 'tutorial.second_date.header'
      className: "point-left"
      details: get_text 'tutorial.second_date.details'
      attachment: "left middle .subject-container .20 .80"
      instruction: get_text 'tutorial.second_date.instruction'
      next: 
        "click button[name=toggle]": "tag_places"
    
    tag_places: new Step
      number: 4
      header: get_text 'tutorial.tag_places.header'
      details: get_text 'tutorial.tag_places.details'
      instruction: get_text 'tutorial.tag_places.instruction'
      attachment: "left center label[for='category-place'] right center"
      focus: "label[for='category-place']"
      next: 
        "click label[for=category-place]": "add_places"
    
    add_places: new Step
      number: 4
      header: get_text 'tutorial.add_places.header'
      className: "point-left"
      details: get_text 'tutorial.add_places.details'
      attachment: "left middle .subject-container .13 .50"
      instruction: get_text 'tutorial.add_places.instruction'
      next: 
        "click button[name=toggle]": "tag_people"
    
    tag_people: new Step
      number: 5
      header: get_text 'tutorial.tag_people.header'
      details: get_text 'tutorial.tag_people.details'
      attachment: "left center label[for='category-person'] right center"
      instruction: get_text 'tutorial.tag_people.instruction'
      focus: "label[for='category-person']"
      next: 
        "click label[for=category-person]": "add_people"
        
    
    add_people: new Step
      number: 5
      header: get_text 'tutorial.add_people.header'
      className: "point-left"
      details: get_text 'tutorial.add_people.details'
      attachment: "left middle .subject-container .45 .85"
      instruction: get_text 'tutorial.add_people.instruction'
      next: 
        "click button[name=toggle]": "tag_other"
    
    tag_other: new Step
      number: 6
      header: get_text 'tutorial.tag_other.header'
      details: get_text 'tutorial.tag_other.details'
      attachment: "left center label[for='category-activity'] right center"
      instruction: get_text 'tutorial.tag_other.instruction'
      focus: "label[for='category-activity']"
      next: 
        "click label[for=category-activity]":"add_activity"
    
    add_activity: new Step
      number: 6
      header: get_text 'tutorial.add_activity.header'
      className: "point-left"
      details: get_text 'tutorial.add_activity.details'
      attachment: "left middle .subject-container .50 .74"
      instruction: get_text 'tutorial.add_activity.instruction'
      next: 
        "click button[name=toggle]": "timeline"
      
    timeline: new Step
      number: 7
      header: get_text 'tutorial.timeline.header'
      details: get_text 'tutorial.timeline.details'
      attachment: "center top button.timeline center bottom"
      instruction: get_text 'tutorial.timeline.instruction'
      next: 
        "click button.timeline":"timeline2"
    
    timeline2: new Step
      number: 7
      header: get_text 'tutorial.timeline.header'
      details: get_text 'tutorial.timeline.details'
      attachment: "right middle .subject-timeline left middle"
      instruction: get_text 'tutorial.timeline.instruction'
      next: 
        "click button.timeline":"talk"
    
    talk: new Step
      number: 8
      header: get_text 'tutorial.talk.header'
      details: get_text 'tutorial.talk.details'
      attachment: "center top button.discuss center bottom"
      instruction: get_text 'tutorial.talk.instruction'
      next: 
        "click button.discuss":"talk2"
      
    talk2: new Step
      number: 8
      header: get_text 'tutorial.talk.header'
      details: get_text 'tutorial.talk.details'
      attachment: "right middle .subject-comments left middle"
      instruction: get_text 'tutorial.talk.instruction'
      next: 
        "click button.discuss":"finished"
      
    finished: new Step
      number: 9
      header: get_text 'tutorial.finished.header'
      details: get_text 'tutorial.finished.details'
      attachment: "center center .subject-container center center"
      instruction: get_text 'tutorial.finished.instruction'
      next: "click button.finish":"profile"
    
    profile: new Step
      number: 9
      header: get_text 'tutorial.profile.header'
      details: get_text 'tutorial.profile.details'
      attachment: "center center .subject-container center center"
      next: "choose"
      
    choose: new Step
      number: 10
      header: get_text 'tutorial.choose.header'
      details: get_text 'tutorial.choose.details'
      attachment: "center center .subject-container center center"
      onEnter: ->
        console.log 'finishing tutorial' 
        Route.navigate '/diaries'
      onExit: ->
        Spine.trigger 'tutorial:done'