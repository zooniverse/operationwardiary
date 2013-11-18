PROJECT_NAME = 'War Diaries'

module.exports =
  
  common:
    other: 'Other'
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
    unit: 'Unit'
    place: 'Place'
    activity: 'Activity'
    quarters: 'Quarters'
    casualties: 'Casualties'
    weather: 'Weather'
    reference: 'Reference'
    mapRef: 'Map sheet'
    gridRef: 'Grid ref'
    signals: 'Reason'
    orders: 'Type'
    title: 'Title'
    
  activities:
    domestic: 'Domestic & army life'
    repair: 'Digging & repairing trenches'
    movement: 'Unit movement'
    reconnoitered: 'Reconnoitering'
    training: 'Training'
    line: 'In the line'
    attack: 'Attacking'
    raid: 'Raiding'
    withdraw: 'Withdrawing'
    quiet: 'All quiet'
    fire: 'Under fire '
    enemy_activity: 'Enemy activity'
    strength: 'Unit strength'
    
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
    joined: 'Joined with'
    
    
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
    profile: 'Profile'
    guide: 'Field Guide'
    about: 'About Us'
    talk: 'Discuss'
    blog: 'Blog'

  home:
    projectDescription: '''
      <p>Help historians by tagging the people, places and activities in 1.5 million pages of official First World War diaries.</p>
    '''
    title: 'Reveal the story of the British Army on the Western Front'
    start: 'Get started!'
  
  help:
    
    diary:
      diaryDate: 'Each entry in the diary page should be dated. Sometimes only the day and month are recorded with the year mentioned only once on a page. If there was little to record or there had been a major incident over a few days the dates might be written as a range. In this case place the first tage at the start of the entry and enter the first date then place the second tage at the end and record the last date in the range.'
      time: 'Exact times were critically important to ensure that co-ordination between different units, between the artillery and infantry and between the air and the ground forces could be achieved. Mistakes with time could prove fatal. Hours and minutes should be recorded using the 24 hour clock.  If a period of time is recorded as a range place the first tage at the start of the entry and enter the first time then place the second tage at the end and record the last time in the range.'
      place: "Each unit started it's War Diary when they were mobilized, so when the first entries were recorded they may still have been in the UK or embarking on a ship. This series of diaries covers the Western Front so all the other places mentioned should be locations in France or Belgium, sometimes called Flanders."
      person: "Because the instructions for writing the diary stipulate that officers should be mentioned by name it has been assumed that very few other ranks can be identified in the diary entries. However units did take different approaches according to the conditions and cirumstances they found themselves in and depending on the individual Adjutant. So now we want to tag every person mentioned by name and reveal why they were mentioned."
      activity: "Despite popular myth not every unit spent four long years in a muddy front line trench with the officers writing poetry! We know that units rotated between being in reserve, to the front line and then to the rear with a period of rest. They moved to different sectors and were engaged in a variety of tasks. Help  us find out how long they spent in each area and what they were doing on a daily basis by tagging the different types of activity."
      casualties: "Field Service Regulations stipluated that only officer casualties should be named. However the diaries do report the total numbers of all casualties by type and sometimes the names. Can you find a casualty report? They are usually found immediately after a period of fighting or at the end of the month."
      weather: "The weather conditions had a significant effect on the life of the men and on the outcome of the fighting. In hot conditions drinking water became an issue whilst in low lying areas heavy rain turned the ground into a swamp. Help us build up the picture by tagging different types of weather. Pick the category that is closest to the description in the diary."
      reference: "Specific incidents may be described in detail in additional documents included as appendices at the end of the month. The C2118 diary page should inlcude a reference or Appendix number to them,usually in the right hand column."
      mapRef: "A series of maps covered the Western Front at different scales. Each map was allocated a sheet number, sometimes with a letter. Each sheet was then divided into 4 (North West, North East, South West and South East). Each of these was subdivided again into 4 numbered sections  (North West 1, North West 2 etc).This identifies a 1:10,000 map sheet - the most common map scale used by units. As the situation changed and trenches moved, maps were re-drawn and a dates was added to the reference. Example: Sheet 28 NW4 Ypres. Fill in as much information as you can."
      gridRef: "Each map sheet was divided into a series of grids. Using a sequence of letters and numbers a square 5 yards by 5 yards could be identified. Each 1:40,000 map sheet was divided into 24 squares lettered A-X. Each of these was subdivided into 36 numbered squares. Each numbered square was subdivided into 4 quarters lettered a-d. Each of the quarters was divided into a 10x10 numbered grid and then finally each 50 yard square subdivided again by 10. Example: M 24 b 35.48. Not all the elements of the grid reference may have been given, so complete the relevant boxes and leave the rest blank."
    
    orders:
      reference: "Each Order would have been given a reference when it was issued. The same Order may have been issued to a number of units."
      date: "This is the date the Orders were issued on. The date is important because different versions of the Order may been issued to update or supersede the original."
      orders: "The title of each Order will indicate the type of activity it refers to.  Pick the category that is closest to the content of the Order. If none of the named categories are releant pick 'Other'"
      
    signals:
      date: "A series of signals can be sent just before and just after midnight so the date is important."
      time: "A series of signals can be sent within a few minutes so the time is important."
      signals: "Choose which of these reasons summarises why the message was sent."
      person: "Tag any individuals named in the report. Tell us who they were and why they were mentioned."
      mapRef: "A series of maps covered the Western Front at different scales. Each map was allocated a sheet number, sometimes with a letter. Each sheet was then divided into 4 (North West, North East, South West and South East). Each of these was subdivided again into 4 numbered sections  (North West 1, North West 2 etc).This identifies a 1:10,000 map sheet - the most common map scale used by units. As the situation changed and trenches moved, maps were re-drawn and a dates was added to the reference. Example: Sheet 28 NW4 Ypres"
      gridRef: "Each map sheet was divided into a series of grids. Using a sequence of letters and numbers a square 5 yards by 5 yards could be identified. Each 1:40,000 map sheet was divided into 24 squares lettered A-X. Each of these was subdivided into 36 numbered squares. Each numbered square was subdivided into 4 quarters lettered a-d. Each of the quarters was divided into a 10x10 numbered grid and then finally each 50 yard square subdivided again by 10. Example: M 24 b 35.48. Not all the elements of the grid reference may have been given, so complete the relevant boxes and leave the rest blank."
      
    report:
      title: "Each report should have a title that describes the content. This might be a Casualty report, a narrative of operations or a nominal roll of the unit."
      date: "The date the report was written."
      reference: "Reports may have been given a reference so it could be easily identified  in the short entry in the diary page."
      person: "Tag any individuals named in the report. Tell us who they were and why they were mentioned."
      

  guide:
    title: 'Transcribing the diaries'
    content: '''
      <p>Field Service Regulations Part II were issued in 1909 and re-printed in 1913. They gave clear guidance about the purpose of the war diary and how and when it was to be completed. But every diary is different! We need to know what type of information it contains by classifying each page of every diary. Using the descriptions of the type of content you are likely to find in each page type and the examples choose one Classification: Blank Page,Cover Page, Diary Page, Orders, Signal, Report, Other</p>
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
        content: 'Reports and appendices are used to provide detailed accounts of a raid or attack or other significant incident, Unit Strength, Casualties or nominal roll.There is often a short entry in the C2118 diary page which references the appendix or report.'
      
      other:
        title: 'Other documents'
        content: 'The diary may include other materials such as maps, sketches, plans, photographs etc. You can include anything not listed in any of the other classes. '

  about:
    diaries:
        title: 'The Unit War Diaries'
        text: '''
          <p>The commanders of the British Army needed to know what was happening with each of the many thousands of military units on active service on a daily basis. The information recorded by the 'Adjutant' in the unit War Dairies helped them move, feed, clothe, equip, train and pay the men. The system enabled them to distribute orders from reminders about when to salute to the tactics to be used to advance against the enemy. But these diaries are more than a dry account of mundane matters.The details of each encounter with the enemy were described and the cost in human life was counted. The extremes of human behaviour - from violence to bravery, from despair to humour are hidden in these pages.</p>
      
          <p>TNA has digitised all 1.5 million pages within the files for units on the Western Front between 1914-1919. The files are made up of a variety of different pieces of paper including the covers that separate individual sections of diary, title pages, orders, singals, maps, narrative reports and the main diary pages themselves. In the years since the diaries were written some sepecific items have been removed for re-filing eg maps and new cover sheets have been added to help with catloguing this huge series. Now we need to know what type of information is on each of the 1.5 millions pages.</p>
        '''
        
      questions:
        title: 'Our Questions'
        text: '''
          <h3>Unit Activity</h3>
          <p>Each unit played it's own individual part in the conflict but it did not operate in isolation. Commanders agreed strategic objectives and their staff officers planned the tactics, engineer units helped move and supply every section of the army; artillery guns worked together to bring down a barrage on enemy positions in support of the infantry; medical units evacuated the wounded and prisoners of war were taken into captivity. But exactly how did all this happen? How much time did each unit spend in the front line, in reserve and at rest? How often were men given the opportunity to have a bath, a clean set of clothes or a trip to see a concert party perform? How did units work together during an attack or retreat? How difficult was it to obtain essential supplies? Was it possible to get hot food to the front line? How did tactics develop, what prompted change and were lessons shared? Tagging all the different types of activity for one unit will enable us to gain a snapshot of life on the Western Front - putting the tags for all the units together will reveal a detailed picture that has never been visible before.</p>
          <h3>People</h3>
          <p>It is generally believed that usually only officers are mentioned by name in the unit war diaries. However, whilst each Adjutant followed guidelines when compiling the diary they were all individuals with different levels of experience, education and enthusiasm for the task! The conditions in which they wrote their reports varied considerably depending on their location, the weather and military situation. So whilst some diaries can be sparse on detail, many others provide a fascinating insight into the activities of named individuals. Until now the only way to find such reports was to read every single page of a diary searching for a refernece to a person. Tagging named individuals will enable us to create an index. Including details of why an individual is named will help us add detail to their Life Story in Lives of the First World War.</p>
          <h3>Weather</h3>
          <p>In popular culture the Western Front was a morass of mud for four long years. But the geology of the battlefield varied dramtically from the low lying fields of Flanders where the water table was barely below the surface to the chalk downs of Picardy. The war was fought in all seasons and the army had to function in all weather conditions. But what effect did the weather have on daily life and on the conduct of the conflict? Tag and describe the weather each day across the Western Front and help us find out.</p>
          <h3>Quarters</h3>
          <p>Units rotated between different duties, taking their turn in the front line, in reserve and at rest. But what conditions did they encounter? How did they live? Did they use local houses and barns, did they pitch tents or bivouak in fields? Tag how the army was 'quartered' and help us learn more about their living conditions.</p>
          <h3>Casualties</h3>
          <p>It was essential for each unit to know it's 'fighting strength' at all times so it needed to keep a record of any casualties. These meant counting those who had been wounded inlcuding those who had been gassed, or the number who were sick and whether they were still able to carry out their duties; those who has been taken Prisoner of War or who were 'Missing' and those who were Killed in Action or who had Died of Wounds. Tag the casualties and help build a picture of the risks of life on the Western Front. Combined with the other information this will help us understand whether and how things changed over time, or in different locations or commands.</p>
        '''
      project:
        title: 'The Diaries of the First World War Project'
        text: '''
          <p>This project is a joint effort between The National Archives (TNA) and Imperial War Museums (IWM). Since 1920 TNA have been the custodians of the original unit War Diaires, responsible for preserving them and making them available to the public. WO95 is one of the most requested series of documents which has meant that the fragile originals are at risk of being damaged by frequent handling. To help with their conservation all the diaries that were written by units on the Western Front from 1914 to 1919 have been digitised at high resolution. A basic catalogue contains the name of the unit, the theatre of operations and the date range covered by each diary. By classifiying details aabout people, places, activities and conditions we can create a rich resource that will help unlock the contents of these contemporary accounts. IWM was founded in 1917 to tell the story of the causes, course and consequences of modern conflicts that involve Britiain and the Commonwealth. To mark the centenary of the global conflict that shaped the word we live in today, IWM is launching Lives of the First World War. This innovative citizen history project will engage a global audience in researching the First World War stories of more than 8 million men and women. The information previously hidden in the unit War Dairies and now revealed through Diaries of the First World War will provide a new and unique dataset that will add fascinating evidence to many of these Life Stories, and saved as a permanent digitial memorial for future generations.</p>
        '''
      
      platform:
        title: 'How the platform works'
        text: '''
          <p>The platform built by Zooniverse captures the place, date and time information you identify and then associates any tags you create with that core data. This means that we can see what happened to the unit, what people were mentioned, how many casualties there had been and what conditions were, within a specific time and location. We can then use that information to create indexes eg of people mentioned by name of a particualr page, we can aggregate the date to provide an overview of different elements of life on the Western Front and academics  can investigate specific questions using detailed and extensive data rather than small scale studies.</p>
        '''
    organizations:
      heading: 'Organizations'

      rsmas:
        image: './images/organizations/rsmas.png'
        name: 'RSMAS'
        url: 'http://www.rsmas.miami.edu/'

      uMiami:
        image: './images/organizations/u-miami.png'
        name: 'University of Miami'
        url: 'http://www.miami.edu/'

      adler:
        image: './images/organizations/adler.png'
        name: 'Adler Planetarium'
        url: 'http://www.adlerplanetarium.org/'

      zooniverse:
        image: './images/organizations/zooniverse.png'
        name: 'Zooniverse'
        url: 'http://www.zooniverse.org/'

    scientists:
      heading: 'The science team'

      cowen:
        image: './images/science-team/cowen.jpg'
        name: 'Bob Cowen'
        role: ''
        description: '''
          Bob Cowen is currently Professor and Maytag Chair of Ichthyology at the University of Miami’s Rosenstiel School of Marine and Atmospheric Science.
          His research interests are focused on larval fish and the plankton communities upon which they depend.
          To better understand life on the time and space scales relevant to these organisms, he seeks novel ways to study the plankton realm.
          The development of the ISIIS imaging system is not only providing unprecedented insight into life in the plankton, but allows Bob to spend untethered days away from his desk on the high seas, ‘eaves-viewing’ on the secret lives of plankters.
        '''

      guigand:
        image: './images/science-team/guigand.jpg'
        name: 'Cedric Guigand'
        role: ''
        description: '''
          Cedric Guigand Is a Senior Research Associate working on the ISIIS instrument from the design and deployment to data analysis.
          Even though his background is in fish biology, he has interests in new technologies and engineering.
          His main contribution to the research done in this laboratory is problem solving and design of new field sampling and lab experimental systems ranging from hybrid multiple net systems to underwater video such as ISIIS.
        '''

      luo:
        image: './images/science-team/luo.jpg'
        name: 'Jessica Luo'
        role: ''
        description: '''
          Jessica Luo is a Ph.D student using ISIIS to study the ecology of jellyfish, larval fish, and other plankton in the ocean.
          She is interested in processes that structure marine communities, and hopes that this research will provide better insight into the role of small jellyfish in the open ocean.
          She moved to Miami in 2010 from Northern California, where she was working as the ocean education coordinator at Point Reyes National Seashore.
          Jessica got her B.S. and M.S. degrees from Stanford University in 2007, studying the chemical oceanography of Red Sea copepods.
          In her free time, she enjoys landscape photography and running 10K’s and half marathons.
        '''

      greer:
        image: './images/science-team/greer.jpg'
        name: 'Adam Greer'
        role: ''
        description: '''
          Adam Greer is a Ph.D student originally from Nashville, TN studying thin layers of zooplankton in coastal environments.
          Plankton often aggregate in dense layers only a few meters in depth, and the use of imaging technology provides a unique opportunity to describe the spatial relationships of organisms in fine detail- leading to a better understanding of how zooplankton and fish larvae feed and survive.
          He also enjoys sports, particularly baseball and basketball, and 90’s rock music.
        '''

      cousin:
        image: './images/science-team/cousin.jpg'
        name: 'Charles Cousin'
        role: ''
        description: '''
          Charles Cousin is involved with the design and manufacturing of the ISIIS towed vehicles.
          He participates in the design of all systems of the instrument, using CAD modeling, drafting, and mechanical analysis tools.
          He also manages manufacturing and is responsible for final assembly of the ISIIS vehicles.
          Charles started his career designing manned submersibles and now focuses his activities helping scientists developed custom oceanographic instruments.
        '''

      grassian:
        image: './images/science-team/grassian.jpg'
        name: 'Ben Grassian'
        role: ''
        description: '''
          Ben Grassian is an undergraduate at the University of Miami who is completing his bachelors in Marine Science and Biology in Summer 2013.
          His research background is mostly in cellular biology, having worked in a cancer research lab in Boston, MA while in high school.
          His work focused on understanding the molecular basis for oncogenic evasion of cell-death pathways via the downregulation of certain proteins.
          He began working with ISIIS image data in the Fall of 2011, focusing on the temporal and spatial distributions of Ctenophore populations in the upper water column.
          He plans on applying to graduate school while finishing his work with ISIIS.
        '''

      tang:
        image: './images/science-team/tang.jpg'
        name: 'Dorothy Tang'
        role: ''
        description: '''
          Dorothy Tang is a research assistant working on the ISIIS images.
          She has been fascinated by the variety of marine ecosystems and life forms since she was a child.
          In order to study more about the oceans and the organisms living in it, she moved from Hong Kong to the United States in 2006.
          She earned her B.S. in Marine Science and Biology in 2012 from the University of Miami.
          She also loves to collect shells.
        '''

    developers:
      heading: 'The development team'

      borden:
        image: './images/dev-team/borden.jpg'
        name: 'Kelly Borden'
        role: 'Education coordinator'
        description: '''
          Kelly is an archaeologist by training but an educator by passion.
          While working at the Museum of Science and Industry and the Adler Planetarium
          she became an enthusiastic science educator eager to bring science to the masses.
          When not pondering the wonders of science, Kelly can often be found baking
          or spending time with her herd of cats – Murray, Ada, & Kepler.
        '''

      carstensen:
        image: './images/dev-team/carstensen.jpg'
        name: 'Brian Carstensen'
        role: 'Front-end developer'
        description: '''
          Brian is a web developer working on the Zooniverse family of projects at the Adler Planearium.
          Brian has a degree in graphic design from Columbia College in Chicago,
          and worked in that field for a number of years before finding a niche in web development.
        '''

      lintott:
        image: './images/dev-team/lintott.jpg'
        name: 'Chris Lintott'
        role: 'Zooniverse science lead'
        description: '''
          Chris Lintott leads the Zooniverse team, and is his copious spare time
          is a researcher at the University of Oxford specialising in galaxy formation and evolution.
          A keen popularizer of science, he is best known as co-presenter of the BBC's long running Sky at Night program.
          He's currently drinking a lot of sherry.
        '''

      miller:
        image: './images/dev-team/miller.jpg'
        name: 'David Miller'
        role: 'Visual designer'
        description: '''
          As a visual communicator, David is passionate about tellings stories through clear, clean, and effective design.
          Before joining the Zooniverse team as Visual Designer, David worked for The Raindance Film Festival,
          the News 21 Initiative's Apart From War, Syracuse Magazine, and as a freelance designer for his small business, Miller Visual.
          David is a graduate of the S.I. Newhouse School of Public Communications at Syracuse University,
          where he studied Visual & Interactive Communications.
        '''

      parrish:
        image: './images/dev-team/parrish.jpg'
        name: 'Michael Parrish'
        role: 'Senior developer'
        description: '''
          Michael has a degree in Computer Science and has been working with The Zooniverse for the past three years as a Software Developer.
          Aside from web development; new technologies, science, AI, reptiles, and coffee tend to occupy his attention.
        '''

      smith:
        image: './images/dev-team/smith.jpg'
        name: 'Arfon Smith'
        role: 'Technical lead'
        description: '''
          As an undergraduate, Arfon studied Chemistry at the University of Sheffield before completing his Ph.D. in Astrochemistry
          at The University of Nottingham in 2006. He worked as a senior developer at the Wellcome Trust Sanger Institute (Human Genome Project) in Cambridge
          before joining the Galaxy Zoo team in Oxford. Over the past 3 years he has been responsible for leading the development of a platform
          for citizen science called Zooniverse. In August of 2011 he took up the position of Director of Citizen Science at the Adler Planetarium
          where he continues to lead the software and infrastructure development for the Zooniverse.
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
    recents: 'Recents'
    favorites: 'Favorites'

  tutorial:
    welcome:
      header: "Welcome to #{PROJECT_NAME}!"
      details: '''
        This short tutorial will show you how to use the tools to mark and identify plankton.
        Before you start, it's a good idea to check out the "science" page to learn about the different species we're classifying.
        Your classifications will be combined with the classifications of other volunteers, so do your best, but don't worry if some seem hard.
      '''

    beforeMark:
      header: 'What we\'re marking'
      details: '''
        Let's start with the large tentacled creature to the right.
        To mark a creature, you need to draw lines across its major and minor axes.
        We're mainly interested in the size and direction of the plankton.
      '''

    majorAxis:
      header: 'Major axis'
      details: '''
        Always mark the length of the plankton first, from the "front" toward the "bottom".
        This will tell us how long the creature is and what direction it's moving.
        Remember to check the science page if you're not sure how to mark something.
        Do not include any tentacles!
      '''
      instruction: 'Drag vertically from the top of the bell across to where the tentacles start.'

    minorAxis:
      header: 'Minor axis'
      details: '''
        Now we'll mark the width of the creature.
      '''
      instruction: 'Drag from left to right across the bell.'

    chooseCategory:
      header: 'Narrow down possible species'
      details: '''
        A row of category icons has appeared. Choose the one that looks closest to the creature you see.
      '''
      instruction: 'Click the icon that best matches the creature.'

    chooseSpecies:
      header: 'Choose the species'
      details: '''
        From the new row of species icons, again click the closest match.
      '''
      instruction: 'Click the icon that best matches the creature.'

    badCoordinates:
      header: 'Close, but no cigar'
      details: '''
        It looks like the axes are a bit off.
        We've drawn some guides to help you out.
      '''
      instruction: 'Drag the handles at the end of each line until they match the guides.'

    wrongSpecies:
      header: 'A case of mistaken identity'
      details: '''
        This creature is actually a $species.
      '''
      instruction: 'Click the icon to re-open the menu, then choose the $species under the $category category.'

    markTheOtherOne:
      header: 'Mark the next creature'
      details: '''
        Try marking the creature in the top-right of the image on your own.
        It's tiny, but try your best to be accurate.
        You can always adjust the lines you've drawn by dragging the end points.
        Remember: Drag out the major axis (length), then the minor axis (width), then choose the species.
      '''
      instruction: 'Mark the next creature on your own.'

    finish:
      header: 'Move on to the next image'
      details: '''
        When you're finished, click "Finish" to submit your classification.
      '''

    beSocial:
      header: 'Be social'
      details: '''
        Before you move on to the next image, you can discuss it with other scientists if you have a question or observation.
        You can also share it with your friends!
      '''
      instruction: 'Click "Next" to load the next image.'

    haveFun:
      header: 'Have fun'
      details: '''
        It looks like you've got a handle on this.
        Enjoy exploring the ocean through a microscope, and thanks for helping with our research!
      '''
