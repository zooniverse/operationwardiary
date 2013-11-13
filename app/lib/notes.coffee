labels =
  toolbars: 
    tags: [
      'diaryDate'
      'time'
      'place'
      'person'
      'activity'
      'casualties'
      'weather'
      'reference'
      'mapRef'
      'gridRef'
    ]
    
    orders: [
      'reference'
      'date'
    ]
    
    signals: [
      'date'
      'time'
      'person'
      'mapRef'
      'gridRef'
    ]
    
    report: [
      'date'
      'reference'
      'person'
    ]

    documents: [
      'blank'
      'cover'
      'diary'
      'orders'
      'signals'
      'report'
      'other'
    ]
  
  activities: [
    'domestic'
    'repair'
    'movement'
    'reconnoitered'
    'training'
    'line'
    'attack'
    'raid'
    'withdraw'
    'quiet'
    'fire'
    'enemy_activity'
    'strength'
  ]
  
  casualties: [
    'killed'
    'died'
    'wounded'
    'prisoner'
  ]
  
  orders: [
    'move'
    'attack'
    'withdraw'
    'entrench'
    'training'
  ]
  
  person: [
    'author'
    'joined'
    'departed_sick' 
    'departed_leave'
    'departed_posted'
    'departed_training'
    'returned_hospital' 
    'returned_leave' 
    'returned_training' 
    'casualty_wounded'
    'casualty_died'
    'casualty_mia'
    'casualty_kia'
    'casualty_pow'
    'award'
    'promotion'
    'combat'
    'discipline'
  ]
    
  quarters: [  
    'billets'
    'bivouac'
    'trenches'
    'firing'
    'communication'
  ]
  
  unit: [
    'relieved'
    'relieved_by'
    'billeted'
    'right'
    'left'
    'joined'
  ]
  
  weather: [
    'fine'
    'storm'
    'hot'
    'heavy_rain'
    'fog'
    'overcast'
    'rain'
  ]  

module.exports = labels