PROJECT_NAME = 'Operation War Diary'

module.exports =
  
  common:
    other: 'Other'
    none: 'None'
    finish: 'Finished!'
    type: 'Type'
    favourite: 'Favourite'
    discuss: 'Discuss'
    comments: 'Talk comments'
    comment: 'Comment'
    timeline: 'Timeline'
    types: 'Page types'
    tagging: 'Get tagging!'
    done: 'All done'
    easy: "That was easy! Click 'Finished' to move on to the next page."
    favourites: "Favourites"
    recent: "Recent pages"
    iwm: "Imperial War Museums"
    tna: "The National Archives"
    zoo: "The Zooniverse"
    start: 'Start'

  documents:
    cover: 'Cover page'
    blank: 'Blank page'
    diary: 'Diary page'
    map: 'Map'
    report: 'Report'
    orders: 'Orders'
    signals: 'Signals pad'
    other: 'Other'

  noteTypes:
    date: 'Date'
    diaryDate: 'Date'
    time: 'Time'
    diaryTime: 'Time'
    person: 'Person'
    unit: 'Other unit'
    place: 'Place'
    activity: 'Unit Activity'
    domestic: 'Army Life'
    quarters: 'Quarters'
    casualties: 'Casualties'
    weather: 'Weather'
    reference: 'Reference'
    mapRef: 'Map sheet'
    gridRef: 'Grid ref'
    signals: 'Reason'
    orders: 'Type'
    title: 'Title'
    
  classifier:
    mapRef:
      sheet: 'Sheet'
      scale: 'Scale'
      date: 'Date'
    person:
      rank: 'Rank'
      first: 'First name'
      surname: 'Surname'
      number: 'Number'
      reason: 'Reason'
      subunit: 'Named unit'
    place:
      name: 'Name'
      location: 'Is the unit currently here?'
    unit:
      name: 'Name'
      context: 'Reason'
      
    
  activity:
    repair: 'Digging & repairing trenches'
    movement: 'Unit movement'
    reconnoitered: 'Reconnoitring'
    training: 'Training'
    line: 'In the line'
    attack: 'Attacking'
    raid: 'Raiding'
    withdraw: 'Withdrawing'
    quiet: 'All quiet'
    fire: 'Under fire '
    enemy_activity: 'Enemy activity'
    strength: 'Unit strength'
    resting: 'Resting'
    
  domestic:
    accomodation: 'Accommodation'
    sport: 'Sport & Leisure'
    religion: 'Religion'
    rations: 'Rations'
    parades: 'Parades'
    inspections: 'Inspections'
    discipline: 'Discipline'
    medical: 'Medical'
    uniform: 'Uniform'
    hygiene: 'Hygiene'
    
  casualties:
    sick: 'Sick'
    missing: 'Missing'
    killed: 'Killed in action'
    died: 'Died of wounds'
    wounded: 'Wounded'
    prisoner: 'Prisoner of war'
    
  orders:
    move: 'Movement'
    attack: 'Attack'
    withdraw: 'Withdrawal'
    entrench: 'Entrenching'
    training: 'Training'
    standing: 'Standing'
    routine: 'Routine'
    
  signals:
    situation: 'Situation report'
    request: 'Request for assistance'
    order: 'Order to attack/withdraw'
    warning: 'Warning of enemy activity'
  
  person:
    author: 'Author of diary'
    joined: 'Joined'
    departed_sick: 'Departed: sick'
    departed_leave: 'Departed: on leave'
    departed_posted: 'Departed: posted to another unit'
    departed_training: 'Departed: training'
    returned_hospital: 'Returned: from hospital'
    returned_leave: 'Returned: from leave'
    returned_training: 'Returned: from training'
    casualty_wounded: 'Casualty: Wounded'
    casualty_died: 'Casualty: Died of Wounds'
    casualty_mia: 'Casualty: Missing in Action'
    casualty_kia: 'Casualty: Killed in Action '
    casualty_pow: 'Casualty: Prisoner of War'
    award: 'Awards and commendations'
    promotion: 'Promoted'
    combat: 'Combat'
    discipline: 'Discipline'
    
  quarters:
    billets: 'In billets'
    bivouac: 'In bivouacs'
    trenches: 'In trenches'
    firing: 'In firing line'
    communication: 'In communication trenches'
    
  unit:
    relieved: 'Relieved'
    billeted: 'Billeted with'
    relieved_by: 'Relieved by'
    right: 'On right'
    left: 'On left'
    joined: 'With'
    
    
  weather:
    fine: 'Dry/Fine/Sunny'
    hot: 'Hot/Very hot'
    overcast: 'Dull/Overcast/Drizzle'
    rain: 'Rain/Storm'
    fog: 'Fog'
    cold: 'Cold/Very cold/Snow'

  navigation:
    projectName: PROJECT_NAME
    home: 'Home'
    classify: 'Classify'
    diaries: 'Diaries'
    profile: 'Profile'
    guide: 'Field Guide'
    about: 'About Us'
    talk: 'Discuss'
    blog: 'Blog'

  home:
    projectDescription: '''
      <p>The story of the British Army on the Western Front during the First World War is waiting to be discovered in 1.5 million pages of unit war diaries. We need your help to reveal the stories of those who fought in the global conflict that shaped the world we live in today.</p>
    '''
    title: "<img class='project_name' src=\"images/logos/owd-hero-logo.svg\" alt='#{PROJECT_NAME}'>"
    start: 'Get started!'
    partners: 'In association with'
    byline: "Working together with Citizen Historians during the First World War Centenary"
    privacy: 'Zooniverse privacy policy'
  
  groups:
    title: 'Pick a diary to work on'
    complete: 'pages complete'
  
  help:
    
    diary:
      diaryDate: 'Each entry in the diary page should be dated. Sometimes only the day and month were recorded with the year mentioned only once on a page. If there was little to record or a major incident had taken place over a few days the dates might have been written as a range. In this case place the first tag at the start of the entry and enter the first date then place the second tag at the end and record the last date in the range.'
      time: 'Exact times were critically important to ensure that co-ordination between different units, between the artillery and infantry and between air and ground forces were achieved. Mistakes with time could prove fatal. Record hours and minutes using the 24 hour clock.  If a period of time is recorded as a range place the first tag at the start of the entry and enter the first time then place the second tag at the end and record the last time in the range.'
      place: "Each unit started it's War Diary when it was mobilized, so the first entries may have been  recorded when they were still in the UK or embarking on a ship. This series of diaries covers the Western Front so all the other places mentioned should be locations in France or Belgium, sometimes called Flanders."
      person: '''
        Because the instructions for writing the diary stipulated that officers should be mentioned by name it has been assumed that very few other ranks can be identified in the diary entries. However units did take different approaches according to the conditions and cirumstances they found themselves in and depending on the individual Adjutant. So now we want to tag every person mentioned by name and reveal why they were mentioned.
      '''
      person_fields: '''
                           <h4>Rank</h4>
                           <p>The army worked on an hierarchical system. Rank was very important as it would indicate a person's level of responsibility. Within each unit selected people were assigned to carry out a specific job. These appointments should not be mixed up with the persons rank. The Adjutant, often a Captain, was the person responsible for writing the War Diary - Adjutant is an appointment whilst Captain is a rank. Choose a rank from the drop down list.</p>
                           <h4>First name</h4>
                           <p>It is not unusual for initials to be used instead of a first name. Record initials with a space between them.</p>
                           <h4>Surname</h4>
                           <p>Double barrelled names either with our without a hypen were common. They should be recorded as written. If you see the same name written more than once see how it is usually written and record it consistently.</p>
                           <h4>Number</h4>
                           <p>Officers did not have Regimental Numbers but Non-Commissioned Officers and Other Ranks did.</p>
                           <h4>Sub unit</h4>
                           <p>Units were broken down into smaller groups of men. Infantry units had 4 Companies, each Company (Coy) had 4 Platoons and each Platoon had 4 Sections, each of approx 12 men. Artillery, cavalry, engineer, medical and other units each had their own structure.  The mention of a sub unit can help pin point an individual.</p>
                           '''
      person_reason:
        heading: "Reason"
        text: '''
                     Each unit had an established strength, with a pre-set number of officers, NCO's and Other Ranks. It was very important that any changes to personnel were recorded. The army used this information so that it could pay each member of the unit correctly, distribute the allocated amount of food, clothing and equipment, arrange for units to move around and fight the war. There were a number of reasons why people may have joined, left or returned to a unit. All ranks attended specialist training courses, particularly as new equipment was introduced and tactics developed. Those attending courses were still 'on the strength' of their unit but were not available to fight so their departure and return needed to be accounted for.
                      '''
        
      
      activity: "Despite popular myth not every unit spent four long years in a muddy front line trench with the officers writing poetry! We know that units rotated between being in reserve, the front line and the rear for a period of rest. They moved to different sectors and were engaged in a variety of tasks. Help us find out how long they spent in each area and what they were doing on a daily basis by tagging the different types of activity."
      casualties: "Field Service Regulations stipluated that only officer casualties should be named. However the diaries do report the total numbers of all casualties by type and sometimes by name. Can you find a casualty report? They are usually found immediately after a period of fighting or at the end of the month."
      weather: "The weather conditions had a significant effect on the life of the men and on the outcome of the fighting. In hot conditions drinking water became an issue whilst in low lying areas heavy rain turned the ground into a swamp. Help us build up the picture by tagging different types of weather. Pick the category that is closest to the description in the diary."
      reference: "The C2118 entry is usually quite brief. More detail was provided in additional documents included as appendices at the end of the month. We need to know what other documents are mentioned. Tag any reference or Appendix number which you will usually find in the right hand column."
      mapRef: "A series of maps covered the Western Front at different scales. Each map was allocated a sheet number, sometimes with a letter. Each sheet was then divided into 4 (North West, North East, South West and South East). Each of these was subdivided again into 4 numbered sections  (North West 1, North West 2 etc).This identifies a 1:10,000 map sheet - the most common map scale used by units. As the situation changed and trenches moved, maps were re-drawn and a dates was added to the reference. Example: Sheet 28 NW4 Ypres. Fill in as much information as you can."
      gridRef: "Each map sheet was divided into a series of grids. Using a sequence of letters and numbers a square 5 yards by 5 yards could be identified. Each 1:40,000 map sheet was divided into 24 squares lettered A-X. Each of these was subdivided into 36 numbered squares. Each numbered square was subdivided into 4 quarters lettered a-d. Each of the quarters was divided into a 10x10 numbered grid and then finally each 50 yard square subdivided again by 10. Example: M 24 b 35.48. Not all the elements of the grid reference may have been given, so complete the relevant boxes and leave the rest blank."
      domestic: "No matter where the unit was and what it was doing everyone still needed to be fed and clothed. But finding a way of bathing 1,000 men and obtaining clean clothes was a challenge that may be recorded in the diary! Parades were held to enable senior officers to communicate with the entire unit. The Padre held church services on a Sunday or before a battle and the Medical Officer carried out inspections to check for trench foot. The men had to be 'quartered' and discipline had to be enforced. Away from the front line there were horse shows and boxing matches, concert parties and sporting fixtures. Tag references to accommodation,sport and leisure, religion, food, parades, inspections, discipline, health, clothing and hygiene."
      unit: "Units did not work in isolation. They took over a sector of the line from the unit they were relieving and were themselves relieved when their tour was complete. They depended on the units on either side of them to protect their flanks and on artillery units to lay down an accurate creeping barrage. Show how units interacted with each other by tagging when other units were mentioned in the war diary."
    
    orders:
      reference: "Each Order was given a reference when it was issued. The same Order may have been issued to a number of units but each copy will have the same reference."
      date: "This is the date the Orders were issued on. The date is important because different versions of the Order may been issued to update or supersede the original."
      orders: "The title of each Order indicates the type of activity it refers to.  Pick the category that is closest to the content of the Order. If none of the named categories are relevant pick 'Other'"
      person: "Because the instructions for writing the diary stipulated that officers should be mentioned by name it has been assumed that very few other ranks can be identified in the diary entries. However units did take different approaches according to the conditions and cirumstances they found themselves in and depending on the individual Adjutant. So now we want to tag every person mentioned by name and reveal why they were mentioned."
      
    signals:
      date: "A series of signals might have spanned the time just before and just after midnight so the date is important."
      time: "A series of signals might have been sent within a few minutes. The time is important so the sequence fo events can be worked out."
      signals: "Choose which of these reasons summarises why the message was sent."
      person: "Tag any individuals named in the signal. Tell us who they were and why they were mentioned."
      mapRef: "A series of maps covered the Western Front at different scales. Each map was allocated a sheet number, sometimes with a letter. Each sheet was then divided into 4 (North West, North East, South West and South East). Each of these was subdivided again into 4 numbered sections  (North West 1, North West 2 etc).This identifies a 1:10,000 map sheet - the most common map scale used by units. As the situation changed and trenches moved, maps were re-drawn and a dates was added to the reference. Example: Sheet 28 NW4 Ypres"
      gridRef: "Each map sheet was divided into a series of grids. Using a sequence of letters and numbers a square 5 yards by 5 yards could be identified. Each 1:40,000 map sheet was divided into 24 squares lettered A-X. Each of these was subdivided into 36 numbered squares. Each numbered square was subdivided into 4 quarters lettered a-d. Each of the quarters was divided into a 10x10 numbered grid and then finally each 50 yard square subdivided again by 10. Example: M 24 b 35.48. Not all the elements of the grid reference may have been given, so complete the relevant boxes and leave the rest blank."
      unit: "Units did not work in isolation. They took over a sector of the line from the unit they were relieving and were themselves relieved when their tour was complete. They depended on the units on either side of them to protect their flanks and on artillery units to lay down an accurate creeping barrage. Show how units interacted with each other by tagging when other units were mentioned in the war diary."
      
    report:
      title: "The report title will provide some information about the content. Common examples included a Casualty Report, a Narrative of Operations or a Nominal Roll of the unit."
      date: "The date on which the report was written."
      reference: "So that the report could be linked to the short entry in the diary page it was given a reference or appendix number."
      person: "Tag any individuals named in the report. Tell us who they were and why they were mentioned."
  
  tools:
    
    activity:
      domestic: "No matter where the unit was and what it was doing everyone still needed to be fed and clothed. But finding a way of bathing 1,000 men and obtaining clean clothes was a challenge that may be recorded in the diary! Parades were held to enable senior officers to communicate with the entire unit. The Padre held church services on a Sunday or before a battle and the Medical Officer  carried out inspections to check for trench foot. The men had to be 'quartered' in billets or tents and discipline had to be enforced. Away from the front line there may have been horse shows and boxing matches, concert parties and sporting fixtures. Tag references to food, clothing, accommodation, parades, sport and leisure, health, religion and discipline."
      repair: "Trenches provided protection and a route for bringing up supplies, equipment and reinforcements. They needed to be carefully constructed and maintained. Tag any mention of the unit digging, repairing or improving trenches or 'saps' (shallow trenches that went out from the main trench system into no-mans-land)."
      movement: "Each movement between the rear, reserve and front line and from one sector of the line to another was carefully co-ordinated. Units may have moved long distances by train or marched. Instructions for the move were sent to the unit as an Order. Tag each time the unit moved location."
      reconnoitered: "A knowledge of the area, the trench system and enemy positions was critical. During the take over of a section of the line the unit reconnoiter the area, sometimes with a guide from the unit handing over. They established the boundaries of the area they were responsible for, note where repairs or strengenthing of the line was needed and where they might be vulnerable. Prior to a raid or attack a unit gathered evidence on the opposing forces. Artillery units needed to find suitable locations for their guns.Tag any mention of a unit reconnoitering, familiarising themselves with the area or sending out patrols."
      training: "Men needed to be trained in tactics and instructed in how to use new equipment as well as staying fit. Tag any references to the unit undergoing instruction or training , including route marches."
      line: "When a unit moved into the line they took over responsibility for that sector of the front, both to defend it against enemy action and to launch a raid or attack from it. Tag any reference to the unit taking over, moving into or being in the (front) line."
      attack: "Headquarters allocated infantry units objectives such as a village or trench line as the focus for their part in an attack. Artillery units supported attacks by laying down a barrage or wall of shells, all in a pre-planned and carefully timed pattern. Other units assisted by bringing up ammunition and other supplies or removing casualties. Tag any mention of the unit participating in or supporting an attack."
      raid: "Not all attacks were large scale battles. Units carried out small scale raids to test the strength of the German units, to gather intelligence and to maintain their aggressive spirit."
      withdraw: "Although there were long periods when the line was static there were also occasions when units had to withdraw, either because they were forced back by a German attack or because it was decided that there were advantages to the line being moved to a different position. Tag any mention of the unit consolidating the line by withdrawing, or retreating or moving back."
      quiet: "Units had to be on the lookout for enemy attacks all the time. If nothing was happening they would record that the situation was quiet."
      fire: "Units came under fire from enemy artillery both as part of the daily routine of trench warfare and also in the lead up to an attack. Tag any reports of the unit being under fire."
      enemy_activity: "Careful observation of enemy troops and artillery could reveal if they were preparing to raid, launch an attack or withdraw. Tag any mention of German activity including troop movements. "
      strength: "Each unit had an established strength, with a pre-set number of officers, NCO's  and Other Ranks. The Adjutant may have recorded this information at intervals, particularly when first arriving in a Theatre of War."
      resting: "Units moved behind the lines for periods of rest. Tag any references to the unit being At Rest or spending a period of time away from the activities of the front and reserve lines."
      
    casualties:
      sick: "A distinction was made between those who were ill and those who had suffered a physical wound. In the unsanitary conditions of the front, sickness of all kinds was prevalent."
      wounded: "Minor wounds were commonplace and may not have been recorded. The casualty return usually included men who were receiving medical treatment and were not on the fighting strength of the unit. Sometimes distinctions are made between men who were wounded but still at their post, men who had been poisoned by gas or who were suffering shell shock symptoms as a result of an explosion eg Wounded (Gas), Wounded (At Duty), Wounded (Shell Shock). Tag them all as Wounded."
      died: "This term was usually used when men who were known to have survived their wouds initially, later died as a result. This could have been on the battlefield if there was a witness to them being wounded but they were later found dead, and then at any point in the medical evacuation system. (DOW)"
      missing: "Anyone who could not be accounted for was reported at 'Missing'. In the confusion of a raid or battle men may have been wounded and either entered the medical evacuation system or have remained on the battlefield unable to move. They may have become muddled up with men from anouther unit, been captured or suffered such catastrophic injuries that it was impossible to identify them. Until some evidence could be found to indicate their fate, such men remained 'Missing in Action' (MIA)"
      killed: "This term was usually used when men were killed outright or when they died on the battlefield. (KIA)"
      prisoner: "It may have taken some time for the names of men captured to be confirmed but sometimes there were witnesses."
      
    unit:
      relieved: "Use this tag if the unit who wrote this diary took over the line from another unit."
      relieved_by: "Use this tag if another unit took over the line from the unit who wrote this diary."
      billeted: "Use this tag if two or more units shared accommodation."
      right: "Use this tag if the unit who wrote this diary are recording the name of the unit on their right."
      left: "Use this tag if the unit who wrote this diary are recording the name of the unit on their left."
      joined: "Use this tag if the unit who wrote the diary, or men from that unti join with another unit."
  
    orders:
      move: "Movement Orders detaied where, when and how a unit was to move location. It may have included a marching table showing how each section of the unit would fit into the plan, the time the unit had to be at a specifc place so that cross roads did not become blocked and how the luggage and equipment was to be transported."
      attack: "Operational Orders gave instructions on the location and time of an attack, what equipment and supplies must be carried and the tactics to be employed."
      withdraw: "A withdrawal may have been ordered because the line could not be held against an enemy attack or because of strategic necessity. On occasion it was agreed that selected ground would be given up in a managed withdrawal so that the line could be consolidated in a better location. The withdrawal needed to be carried out very carefully so that the German forces could not exploit the situation."
      entrench: "Trenches provided protection and a route for bringing up supplies, equipment and reinforcements. They needed to be carefully constucted and maintained. Different techniques were employed depending on the purpose of the line and the local geology."
      training: "Over the course of the conflict considerable developments occurred in how war was waged. Each side introduced new technolgy such as tanks, poison gas and aeroplanes. In response the army developed new techniques to protect themselves, such as improvements to the trench system, and learnt new tactics to use the opportunities they offered. Training and instruction was important to ensure confusion on the battlefield was avoided. Selected officers and men were sent on specific training courses but Training Orders were also issued where information needed to be shared with every individual."
      standing: "Standing Orders were permanently in force and established the set way to carry out a task or the rules on behaviour. They were updated when necessary. All members of the unit were expected to be familiar with Standing Orders."
      routine: "Routine orders were issued periodically by the unit and contained notices and updates eg upcoming parades or promotions. All members of the unit were expected to be familiar with Routine Orders."
  
    signals:
      situation: "A report of the situation in the front line."
      request: "A request for assistance in the front line including sending up re-inforcements, ammunition or equipment."
      order: "An instruction from HQ to the men in the front line to 'hold the line', to push forward with the attack or to withdraw."
      warning: "An alert from either the front line to HQ or from HQ to the front line warning of an enemy attack."
  
    person:
      author: "One officer in each unit was appointed as 'Adjutant', responsible for all the unit administration including writing the unit war diary."
      joined: "The arrival of a new officer was usually recorded in the unit diary. This may have been a permanent move or he may have been 'attached' for a time."
      departed_sick: "The army made a clear distinction between those who were 'sick' and those who had been 'wounded'. The departure of officers who were too ill to continue with the unit was usually recorded." 
      departed_leave: "Leave was granted to allow personnel to travel to a quiet location well behind the lines. Occasionally they were given enough time to travel back to the UK on 'Home Leave'. This may have been granted for personal circumstances eg the death of a child or if an individual was close to exhaustion."
      departed_posted: "Officers were moved between units so they could share their knowledge and experience, which were important factors in how successful a unit could be. They might also be moved on promotion or posted to a quieter unit after prolonged periods of intense fighting."
      departed_training: "Where specialist training or instruction was required personnel were sent on courses. Their temporary departure was recorded."
      returned_hospital: "The return of individuals from training courses, from hospital when they had recovered from wounds or sickness or from leave was recorded." 
      returned_leave: "The return of individuals from training courses, from hospital when they had recovered from wounds or sickness or from leave was recorded." 
      returned_training: "The return of individuals from training courses, from hospital when they had recovered from wounds or sickness or from leave was recorded." 
      casualty_wounded: "Distinctions were made between men who were wounded but still at their post, men who had been poisoned by gas or who were suffering shell shock symptoms as a result of an explosion eg Wounded (Gas), Wounded (At Duty), Wounded (Shell Shock). They should all be tagged as Wounded."
      casualty_died: "This term was used when men who were known to have survived their wounds initially, later died as a result. This could have been on the battlefield if there was a witness to them being wounded but they were later found dead, and then at any point in the medical evacuation system. (DOW)"
      casualty_mia: "Anyone who could not be accounted for was reported at 'Missing'. In the confusion of a raid or battle men may have been wounded and either entered the medical evacuation system or have remained on the battlefield unable to move. They may have become muddled up with men from anouther unit, been captured or suffered such catastrophic injuries that it was impossible to identify them. Until some evidence could be found to indicate their fate, such men remained 'Missing in Action' (MIA)"
      casualty_kia: "This term was used when men were killed outright or when they died on the battlefield. (KIA)"
      casualty_pow: "It may have taken some time for the names of men captured to be confirmed but sometimes there were witnesses."
      award: "Individuals who had carried out specific acts of bravery or who had behaved courageously over a long period may have been nominated for a commendation or award. Both the nomination and the receipt of the award may be recorded."
      promotion: "A unit required a set number of officers of each rank. A promotion may have been based on experience and the result of the normal army process, or happened in the field due to the need to replace officer casualties. It was possible for a man to be promoted from the ranks and become an officer. Once promoted an officer may subsequently have moved to another unit. It was important that the correct rank was recorded by the unit as pay was based on rank."
      combat: "The actions of individuals during trench raids, large scale attacks and withdrawals were sometimes recorded."
      discipline: "Behaviour and conduct was controlled by Army Regulations. Anyone who broke the rules was subject to strict discipline. Punishments may have been carried out in front of the unit. More severe offences might have involved the individual being taken into custody and removed from the unit by the military police. These events may have been recorded in the unit diary."
      
    domestic:
      accomodation: "Accommodation varied according to where the unit was in realtion to the line. Tag terms including billets, quarters, bivouacs, camps, tents and dug outs."
      sport: "Behind the line the men were kept occupied and entertained with sporting events, concerts, competitions and dinners."
      religion: "Tag references to religion, church services, communion, burial services conducted and other work of the unit Padre or Chaplain."
      rations: "Tag any mention of food including rations being acquired, prepared or delivered inlcuding food parcels received from home."
      parades: "Units paraded for the visit of a senior office or VIP, when awards were being presented, to enable the commander to talk to everyone at the same time and to commemorate a significant event in the history of the unit. Do not include parades for religious or medical reasons which should be tagged separately."
      inspections: "Inspections took place to check that the men were correctly dressed, equipped and trained."
      discipline: "Even minor infringements of the rules could have serious consequences eg a dirty rifle might not fire correctly. Depending on the offence men were disciplined by their unit or referred up the chain. Tag any reference to discipline, arrest, punishment, forfeiture of pay, demotion or courts martial."
      medical: "Tag any reference to routine medical inspections eg for trench foot, vaccinations or the work of the unit Medical Officer (MO)."
      uniform: "Tag any mention of the men receiving clean clothing or new equipment."
      hygiene: "It was extremely difficult to provide proper washing facilities so baths were improvised from farm carts and streams and ponds were used for swimming. Lice infested clothes and spread disease. Tag any mention of washing, fumigation or any other element of personal hygiene."

  guide:
    title: 'Transcribing the diaries'
    content: '''
      <p>Field Service Regulations Part II were issued in 1909 and re-printed in 1913. They gave clear guidance about the purpose of the war diary and how and when it was to be completed. But every diary is different! Help us reveal what information they contain by classifying each page of every diary. Using the descriptions of the type of content you are likely to find in each page type and the examples, choose one Classification: Blank Page,Cover Page, Diary Page, Orders, Signal, Report, Other</p>
    '''
    classify: "Continue classifying"
    tutorial: "Restart the tutorial"
    
    tags:
      title: 'Tagging the diaries'
      content: '''
                     Select a tag for help and guidance with tagging that type of page.
                     '''
      
    diaries:

      blank:
        title: 'Blank page'
        content: 'You may come across a blank page, possibly a cover or a piece of paper folded around a series of pages, or an unused diary page or signal sheet. You can also include anything with \'intentionally blank\' written on it in this class.'

      cover:
        title: 'Cover page'
        content: 'Each diary section had a cover page with the name of the unit and dates included. When the diary was passed up the army chain of command and then into the care of TNA additional cover pages may have been added. You can include anything that just contains title information.'
      
      diary:
        title: 'Diary page'
        content: 'The pre-printed C2118 forms provided units with a structured way in which to record essential information about their activities. But when some units mobilized (went on active service) the  forms were not available so officers used their notebooks. It is most common to find this happen in the early months of the war from August 1914 and when units first went overseas. You can include any page that has been written as a diary entry even if it isn\'t on a C2118 form. Once you have classified an item as a Diary Page you can then start tagging key pieces of information on that page.'
        
      signals:
        title: 'Signals Pads'
        content: 'Signals pads were used for short, urgent messages between front line positions and unit headquarters (HQ) or between unit HQ and their command chain. They may have been delivered by a \'runner\'. Once you have classified an item as a Signal you can then tag key pieces of information.'
      
      orders:
        title: 'Orders'
        content: 'Orders were official army instructions, issued in a cascade system from the top of the hierarchy to the bottom. Each Order had a specific purpose and covered a single subject or event. They were issued on every aspect of army life and activity. Once you have classified an item as an Order you can then tag key pieces of information including what the instructions were for.'
      
      report:
        title: 'Reports'
        content: 'Reports and appendices were used to provide detailed accounts of a raid or attack or other significant incident, Unit Strength, Casualties or nominal roll.There was often a short entry in the C2118 diary page which referenced the appendix or report.'
      
      other:
        title: 'Other documents'
        content: 'The diary may include other materials such as maps, sketches, plans, photographs etc. You can include anything not listed in any of the other classes. '

  about:
    diaries:
        title: 'The Unit War Diaries'
        text: '''
          <p>War diaries were kept for two reasons: to provide an accurate record of operations for preparing the official history of the war, and to collect information that would help make improvements in preparing the army for war.</p>
          <p>The war diaries contain a wealth of information of far greater interest than the army could ever have predicted. They provide unrivalled insight into daily events on the front line, and are full of fascinating detail about the decisions that were made and the activities that resulted from them.</p>
      
          <p>The National Archives has digitised the war diaries of the units under the command of the British and Indian cavalry and infantry divisions on the Western Front. The war diaries are made up of a variety of different types of pages, including cover pages, title pages, orders, signals, maps, narrative reports and the main diary pages themselves. They are catalogued by theatre of operations, unit and the date range covered, but we don&#039;t know much more about the content of the diaries beyond this. </p>
        '''
      
      outcomes:
        title: 'The Project Outcomes'
        text: '''
              <p>Data gathered through Operation War Diary will be used for three main purposes:</p>
              
              <ul>

              <li>to enrich The National Archives&#039; catalogue descriptions for the unit war diaries,</li>
              
              <li>to provide evidence about the experience of named individuals in IWM&#039;s Lives of the First World War project</li>
              
              <li>to present academics with large amounts of accurate data to help them gain a better understanding of how the war was fought</li>
              
              </ul>

              <p>Operation War Diary depends on the work done by The National Archives to digitise the unit war 
              
                            diaries, and they&#039;ve made individual pages available free of charge on the Zooniverse platform for this 
              
                            project. Whole war diaries are available from Discovery, The National Archives&#039; catalogue, where they 
              
                            can be searched free of charge and downloaded for a small fee.</p> 

              <p>All of the data produced by Operation War Diary will eventually be available to everyone free of 
              
                            charge- a lasting legacy and a rich and valuable introduction to the world of the War Diaries.</p>
              '''
        
        
      questions:
        title: 'Our Questions'
        text: '''
          <p>Historians at IWM and The National Archives have worked with members of IWM&#039;s Digital Centenary

Academic Advisory Group to compile a list of questions that the data in the unit war diaries will help 

them explore.</p>
          <div>
          <h3>Military Activity</h3>
          <p>Each unit played its own individual part in the conflict but it did not operate in isolation. Commanders agreed strategic objectives and their staff officers planned the tactics, engineer units helped move and supply every section of the army; artillery guns worked together to bring down a barrage on enemy positions in support of the infantry; medical units evacuated the wounded and prisoners of war were taken into captivity. But exactly how did all this happen? How much time did each unit spend in the front line, in reserve and at rest?  How did units work together during an attack or retreat?  How did tactics develop, what prompted change and were lessons shared? Tagging key types of activity for one unit will enable us to gain a snapshot of life on the Western Front - putting the tags for all the units together will reveal a detailed picture that has never been visible before.</p>
          </div>
          <div>
          <h3>People</h3>
          <p>It is generally believed that only officers are mentioned by name in the unit war diaries. However, whilst each Adjutant followed guidelines when compiling the diary they were all individuals with different levels of experience, education and enthusiasm for the task! The conditions in which they wrote their reports varied considerably depending on their location, the weather and military situation. So whilst some diaries can be sparse on detail, many others provide a fascinating insight into the activities of named individuals. Until now the only way to find such reports was to read every single page of a diary searching for a reference to a person. Tagging named individuals will enable us to create an index. Including details of why an individual is named will help us add detail to their Life Story in Lives of the First World War.</p>
          </div>
          <div>
          <h3>Weather</h3>
          <p>In popular culture the Western Front was a morass of mud for four long years. But the geology of the battlefield varied dramatically from the low lying fields of Flanders where the water table was barely below the surface to the chalk downs of Picardy. The war was fought in all seasons and the army had to function in all weather conditions. But what effect did the weather have on daily life and on the conduct of the conflict? Tag and describe the weather each day across the Western Front and help us find out.</p>
          </div>
          <div>
          <h3>Army Life</h3>
          <p>Little time was actually spent in combat, so what was life like on the Western Front when you were not fighting? How did the men live? How often did they eat hot food, have a bath or change their clothes? When they were resting how did they entertain themselves? Tag mentions of concert parties, sporting events, religious services, food, hygiene and help us learn more about life beyond the fighting. </p>
          </div>
          <div>
          <h3>Casualties</h3>
          <p>It was essential for each unit to know its 'fighting strength' at all times. This meant compiling Casualty returns, counting those who had been wounded including those who had been gassed, or the number who were sick and whether they were still able to carry out their duties; those who has been taken Prisoner of War or who were 'Missing' and those who were Killed in Action or who had Died of Wounds. Tag the casualties and help build a picture of the risks of life on the Western Front. Combined with the other information this will help us understand whether and how things changed over time, or in different locations or commands.  </p>
          </div>
        '''
      project:
        title: "About #{PROJECT_NAME}"
        text: '''
        <p>Operation War Diary brings together original First World War documents from The National Archives, the historical expertise of IWM and the power of the Zooniverse community.</p>

        <p>It will create new &lsquo;Citizen Historians&#039;. Working together we will make previously inaccessible information available to academics, researchers and family historians worldwide, leaving a lasting legacy for the centenary of the First World War.</p>
        '''
      
      platform:
        title: 'How the platform works'
        text: '''
          <p>The platform built by Zooniverse captures the place, date and time information you identify and then associates any tags you create with that core data. This means that we can see what happened to the unit, what people were mentioned, how many casualties there had been and what conditions were, within a specific time and location. We can then use that information to create indexes eg of people mentioned by name of a particular page, we can aggregate the date to provide an overview of different elements of life on the Western Front and academics can investigate specific questions using detailed and extensive data rather than small scale studies.</p>
        '''
      
      browsers:
        title: 'Browsers'
        text: '''
              <p>The platform is designed to work on a PC with IE 9 (or higher) or with latest versions of Chrome and
              
                            Firefox. On a Mac it is designed to work with the latest version of Safari. On PCs running Windows XP 
              
                            the platform will work with latest versions of Chrome and Firefox, but not with IE 8.</p> 

              <p>Users of older browsers will need to upgrade to ensure all the site functionality is available.</p>
              '''
      
      people:
        title: 'About the people'
        
        luke:
          bio: "Luke is Digital Lead for the First World War Centenary at Imperial War Museums. He leads IWM's Lives of the First World War and is passionate about engaging large numbers of people in Citizen History. Luke has delivered complex online systems at Sony Playstation, Arts Council England and elsewhere. 2014 is a big year for Luke but he'll still find time for seeing obscure rock bands, flying kites with his children and going on a few sailing trips."
        
        mel:
          bio: "Mel is the Project Manager for IWM's Lives of the First World War and spends far too much time researching family history. She has had an eclectic career journey, starting as an RAF Air Traffic Control officer before moving on via the NHS to IWM. Prior to Lives of the First World War she worked on the Their Past Your Future project leading commemorative visits to the battlefields."
          
        nigel:
          bio: "Nigel is Principal Historian for the First World War Centenary at Imperial War Museums. He is a leading public historian, has published several books on the war and makes frequent appearances on television. He is actively involved in digital projects for the centenary."
          
        heath:
          bio: "UI/UX Designer at the Zooniverse in Chicago. He makes websites look and feel amazing."
        
        michael:
          bio: "Zooniverse developer at the Adler Planetarium in Chicago. He pwns databases daily. Likes dogs and bourbon."
        
        stuart:
          bio: "Zooniverse developer at the Adler Planetarium in Chicago. Data analysis maestro."
          
        jim:
          bio: "Just this guy, you know?"
        
    organisations:
      heading: 'The partnership'

      tna:
        image: 'images/logos/tna-gray.png'
        name: 'The National Archives'
        url: 'http://www.nationalarchives.gov.uk/'
        text: '''
          <p>The National Archives holds the unit war diaries and is responsible for preserving and making them available to the public, along with millions of other public records. The diaries are among the most requested documents in The National Archives reading rooms, and complement other digitised record series already available to researchers such as service records and medal index cards.</p> 
          <p>The catalogue descriptions for the unit war diaries contain the name of the unit, the theatre of operations and the date range covered by each diary. By adding details about the people, places and activities within the diaries using the data captured by Operation War Diary citizen historians, we can create a rich resource that will help unlock the contents of these contemporary accounts.</p>
          '''
        

      iwm:
        image: 'images/logos/iwm-gray.svg'
        name: 'Imperial War Museums'
        url: 'http://iwm.org.uk/'
        text: '''
        <p>IWM was founded in 1917 to tell the story of the causes, course and consequences of modern conflicts that involve Britain and the Commonwealth. To mark the centenary of the global conflict that shaped the word we live in today, IWM is launching Lives of the First World War. This innovative citizen history project will engage a global audience in researching the First World War stories of more than 8 million men and women.</p> 
        <p>Operation War Diary will unlock the information previously hidden in the unit diaries, providing a new and unique dataset that will add fascinating evidence to many of those Life Stories. These will be shared on Lives of the First World War and saved for future generations as part of the permanent digital memorial.</p>
        '''
        

      zooniverse:
        image: 'images/logos/zooniverse-logo.svg'
        name: 'Zooniverse'
        url: 'http://www.zooniverse.org/'
        text: '''
        <p>Zooniverse was established in 2007 to use the efforts and ability of volunteers to help scientists and researchers deal with the flood of data that confronts them.</p>
        <p>It is a collaboration between universities and museums, led by the University of Oxford and the Adler Planetarium in Chicago, which creates citizen science and humanities projects. To date, nearly a million people have used Zooniverse websites to discover planets, transcribe ancient papyri and keep an eye on plankton. The Operation War Diary project builds on the team&#039;s experience with the award-winning Old Weather project, which has mined more than a million pages drawn from 19th and early 20th century ship&#039;s logs in order to find information of interest to climate scientists and historians.</p>
        '''
        


  classify:
    metersUnit: 'm'
    degreesUnit: '°C'
    numberCounted: 'Number counted'
    finish: 'Finish'
    discuss: 'Discuss'
    favorite: 'Favorite'
    next: 'Next'
    share: 'Share'
    tweet: 'Tweet'
    return: 'Home'

  profile:
    recents: 'Recent pages'
    favourites: 'Favourites'
    groups: 'Your diaries'
    tags: 'Your tags'
    activities: 'Activities'
    dates: 'Dates'
    places: 'Places'
    people: 'People'
    login: 'Login to view profile'

  tutorial:
    welcome:
      header: "Welcome to #{PROJECT_NAME}!"
      details: '''
        <p>Become a Citizen Historian and help Imperial War Museums and The National Archives reveal the story of the British Army on the Western Front during the First World War.</p>
      '''

    intro:
      header: "Check out the diaries"
      details: '''
        <p>Around 1.5 million pages of unit war diaries cover activity on the Western Front. There are lots of different types of pages full of fascinating details about the people involved and descriptions of their activities. </p>
        <p>We need your help to classify the type of page and then tag key data.</p>
      '''
    
    about:
      header: "About #{PROJECT_NAME}"
      details: '''
                   <p>From the tags we can create a detailed index to the people who appear in these pages and learn more about what they were doing. We are not transcribing every word.</p>

                   <p>This short tutorial will walk you through the classification and tagging process.</p> 
                 
                   '''
      instruction: "Let's get started!"
    

    page_type:
      header: "Classifying diary pages"
      details: '''
        <p>Choose the classification that best matches the page you can see. If you are not sure which one to choose, you can see examples in the Field Guide.</p>
        <p>You can return to the menu by clicking on '1 Page Types'.</p>
        <p>Around half of the pages are standard diary pages, like this one.</p>
      '''
      instruction: "Select <b>Diary page</b> from the Page Types menu"

    get_tagging:
      header: "Get tagging"
      details: "<p>Now that you&#039;ve decided what type of page it is, it&#039;s time to start tagging!</p>
<p>Different page types contain different pieces of information, so the list of available tags will change depending on your page classification.</p>
  <p>We can&#039;t tag everything!</p>
  <p>There are tags for all the key pieces of information that we need to know about.</p>
  "

    tagging_intro:
      header: "Tagging the diary pages"
      details: '''
        <p>Most (not all) Diary pages use a pre-printed template with 5 columns</p>
        <ul>
          <li> 1-3: place, date and hour</li>
          <li> 4: narrative account of operations, which can contain a variety of  information about people and activities. </li>
          <li> 5: References  to other documents in the diaries including maps and reports.</li>
        </ul>
        <p>Look at the page in more detail by using the magnifying tool to zoom in/out.</p>
      '''

    tag_dates:
      header: "Tagging dates and times"
      details: '''
        <p>Start tagging by working your way down the Date column.</p>
              <p>This will group events together and create a timeline of activity without you having to add a date to every other tag.</p>
      '''
      instruction: "Select <b>Date</b> from the Tag menu"

    add_dates:
      header: "Adding a date"
      details: '''
        <p>There are a number of entries at different times on 20 May.</p>
        <p>Place the tag above the text of the first entry. A horizontal line appears, to indicate the start of the text for that day.</p>
        <p>If the tag box is covering the area of the page you want to look at, drag it to a new position.</p>
      '''
      instruction: "Choose 20 May 1915 from the calendar tool. Click on the &#x2714; button to confirm."

    second_date:
      header: "Adding a second date"
      details: '''
        <p>Now do the same thing for the next date, 21 May, and a second line will appear, dividing the page into sections.</p>
        <p>You can adjust the position of a tag by dragging the icon.</p>
      '''
      instruction: "Choose 21 May 1915 from the calendar tool and confirm your tag."

    tag_places:
      header: "Tagging places"
      details: "<p>Once you have tagged all the dates follow the same approach for the Places column.</p>
<p>This shows the unit location when the diary entry was written. Other places may be mentioned in the narrative column.</p>"
      instruction: "Select the <b>Place</b> tag"
    
    add_places:
      header: "Choosing a place"
      details: "<p>Click on the second entry for 20 May where it says 'Aldershot' to attach the tag.</p>

<p>Enter the place name in the pop-up box. If there are multiple options, choose the most likely location from the list using the map to help you. If you&039;re not sure select 'None of these'.</p>
"
      instruction: "Enter 'Aldershot' in the text box and select the 'Is the unit currently here?' box."
      
    tag_people:
      header: "Tagging people"
      details: "<p>Once you have completed all the dates, places and times look at the fourth column for any mention of people and activities.</p> 
<p>As an example, can you see an individual mentioned by name on this page?</p>
<p><b>1860, Sergeant Byrne</b> became a casualty on 21 May.</p>"
      instruction: "Select <b>Person</b> and attach the tag by his name"
      
    add_people:
      header: "Tell us why they were mentioned"
      details: "<p>Then fill in as much detail about the individual as you can see on the page, including their rank and regimental number if given.</p> 
<p>Choose a <b>Reason</b> from the drop down list that explains why they are mentioned. The Adjutant has stated that Sgt Byrne was a casualty so choose the closest match &ndash; Casualty:Wounded</p>"
      instruction: "Fill in Sergeant Byrne's details. If you make a mistake you can delete the tag by clicking on the X."
    
    tag_other:
      header: "Tagging other information"
      details: "<p>You may find other key pieces of information such as what the unit was doing or what the weather was like.</p>

<p>The Field Guide gives help on what to tag as well as examples of military phrases that you might come across.</p>

<p>On this diary page there is a description of the Battalion embarking on the SS Victoria.</p>"
      instruction: "Select the <b>Unit Activity</b> tag."
    
    add_activity:
      header: "Unit Activity"
      details: "<p>Place the tag where it says 'Embarked' and then choose an entry from the drop down list that most closely matches the action described in the diary &ndash; in this case <b>Unit Movement</b></p>
<p>If you can&#039;t find a relevant description have a look at the <b>Army Life</b> tag list which includes domestic activities, religion, sport and food.</p>"
      instruction: "Choose 'Unit movement' and click the &#x2714; box to complete the tag."
    
    timeline:
      header: "Editing or deleting tags"
      details: "<p>Before you finish a page, you can review your tags to make sure that you&#039;re happy with them.</p> 
      <p>Click on the <b>timeline</b> button to see all the tags that you&#039;ve attached to this image &ndash; you can then click on individual tags to edit, move or delete them.</p>"
      instruction: "Click the <img src='images/icons/timeline.png' alt='timeline'> button."
    
    talk:
      header: "Have you found an entry that you want to talk about?"
      details: '''
          <p>If you want to share an interesting entry or discuss a problem, you can use the <b>talk</b> button to comment on this page.</p>

          <p>Add hashtags in your comment to link this page with similar pages in Talk.</p>
          
            
            '''
      instruction: "Click the <img src='images/icons/talk.png' alt='talk'> button."
      
    finished:
      header: "Finished"
      details: '''
        <p>Once you&#039;re happy that you&#039;ve tagged as much as you can, click <b>Finished</b>.</p>
        <p>This will submit the page with your tags so you cannot go back to make any changes.</p>

        <p>Don&#039;t worry about missing a tag or making a mistake.</p> 

        <p>To get results that are as accurate as possible, each page will be tagged more than once and all the tags compared.</p>
        
        '''
      instruction: "Click <b>Finished!</b>"
    
    profile:
      header: "Your profile"
      details: '''
          <p>You can see which diary pages you have classified and a summary of the tags you have submitted on your Profile page.</p>

          <p>If you want to download a full diary you can visit The National Archives site (TNA fees may apply).</p>
          
                     '''
      
    
    choose:
      header: "What happens next"
      details: "<p>Well done! You have successfully completed the tutorial.</p>
<p>If you want repeat it, you will find the tutorial link in the Field Guide.</p>

<p>If you are happy to start classifying and tagging, log in to your Zooniverse account, choose a diary and get started.</p>"


