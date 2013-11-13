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
    start: 'Start searching'
    about: 'About'
    images: 'Images'
    species: 'Species'

  guide:
    title: 'Transcribing the diaries'
    content: '''
      <p>Overview of transcribing the papers.</p>
    '''
    diaries:
      title: 'British Army Diaries'
      content: '''
        <p>Summary goes here.</p>
      '''

      blank:
        title: 'Blank page'
        content: 'TODO'

      cover:
        title: 'Cover page'
        content: 'TODO'
      
      diary:
        title: 'C2118 form'
        content: 'TODO'
        
      map:
        title: 'Maps'
        content: 'TODO'
      
      report:
        title: 'Reports'
        content: 'TODO'
      
      other:
        title: 'Other documents'
        content: 'TODO'

  about:
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
