TextWidget = require './text-widget'
labels = require '../notes'

class PersonWidget extends TextWidget
  @ranks = [
    'Assistant Paymaster'
    'Battery Sergeant Major'
    'Bombardier'
    'Brigadier'
    'Brigadier General'
    'Captain'
    'Chaplain'
    'Colonel'
    'Colour Sergeant'
    'Company Quarter Master Sergeant'
    'Company Sergeant Major '
    'Corporal'
    'Driver'
    'Drummer'
    'Farrier'
    'Farrier Sergeant'
    'Field Marshal'
    'Fusilier'
    'General'
    'Guardsman'
    'Gunner'
    'Lance Bombardier'
    'Lance Corporal'
    'Lance Sergeant'
    'Lieutenant'
    'Lieutenant Colonel'
    'Lieutenant General'
    'Major'
    'Major General'
    'Officer Cadet'
    'Paymaster'
    'Pioneer'
    'Private'
    'Quarter Master Sergeant'
    'Regimental Quarter Master Sergeant'
    'Regimental Sergeant Major'
    'Rifleman'
    'Sapper'
    'Second Corporal'
    'Second Lieutenant'
    'Sergeant'
    'Sergeant Major'
    'Shoeing Smith'
    'Signaller'
    'Staff Sergeant'
    'Trooper'
    'Warrant Officer'
    'Warrant Officer Class I'
    'Warrant Officer Class II'
  ]
  
  template: require('../../views/tools/person')( ranks: PersonWidget.ranks, context: labels.person )
  
  type: 'person'
  help: '/diary/person'
  
  updateNote: (target)->
    note =
      rank: ''
      first: ''
      surname: ''
      number: ''
      reason: ''
      unit: ''
    
    $( target )
      .parents( '.annotation')
      .find( ':input')
      .each ->
        note[@name] = @value
    
    note
    
  getLabel: (target) ->
    note = @updateNote(target)
    reason = @el.find('select[name=reason] :selected').text()
    "#{note.rank} #{note.first} #{note.surname}\n(#{reason})"

module.exports = PersonWidget
