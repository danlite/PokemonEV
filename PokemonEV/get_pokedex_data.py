import pokedex
import pokedex.db.tables as tables

from sqlalchemy import func, or_

from string import capwords

from shutil import copy

from plistlib import writePlist

session = pokedex.db.connect()

q = session.query(tables.PokemonForm, tables.PokemonDexNumber.pokedex_number)\
					.outerjoin((tables.Pokemon, tables.PokemonForm.form_base_pokemon))\
					.join((tables.PokemonDexNumber, tables.PokemonDexNumber.pokemon_id==tables.Pokemon.id))\
					.filter(tables.PokemonDexNumber.pokedex_id==1)\
					.order_by(tables.Pokemon.id, tables.PokemonForm.id)
					
rs = q.all()

pokemon_list = []
stat_prefixes = ['', 'hp', 'attack', 'defense', 'spAttack', 'spDefense', 'speed']

# Forms which have do not need to differentiated for EV training purposes
ev_identical_forms = ["Pichu", "Unown", "Castform", "Burmy", "Cherrim", "Shellos", "Gastrodon", "Rotom", "Giratina", "Arceus", "Basculin", "Deerling", "Sawsbuck", "Genesect"]
identical_form_counts = {}
for name in ev_identical_forms:
  identical_form_counts[name] = 0

for f,d in q.all():
  form_name = f.name
  pokemon = f.unique_pokemon if f.unique_pokemon else f.form_base_pokemon
  pokemon_name = pokemon.name
  
  pokemon_stats = sorted(pokemon.stats, key=lambda stat: stat.stat_id)
  
  if form_name:
    image_filename = '{id}-{form}.png'
  else:
    image_filename = '{id}.png'
  
  image_filename = image_filename.format(
    id=f.form_base_pokemon_id,
    form=f.identifier
  )
  
  if pokemon_name in ev_identical_forms:
    if identical_form_counts[pokemon_name] == 0:
      # Choose the first encountered form of Pokemon with EV-identical forms and do not use its form name
      identical_form_counts[pokemon_name] = 1
      form_name = None
    elif identical_form_counts[pokemon_name] > 0:
      # Skip over already encountered forms of Pokemon with EV-identical forms
      continue
  
  image_original = '../../external/veekun/pokedex-media/pokemon/icons/' + image_filename
  copy(image_original, './Images/pokemon_icons/')
  
  pokemon_dict = {
    'dexNumber': d,
    'formOrder': f.order,
    'iconFilename': image_filename,
    'name': pokemon_name,
  }
  
  if form_name:
    pokemon_dict['formName'] = form_name
  
  for stat in pokemon_stats:
    prefix = stat_prefixes[stat.stat_id]
    pokemon_dict[prefix + 'Effort'] = stat.effort
    
  pokemon_list.append(pokemon_dict)

writePlist(pokemon_list, 'pokedex.plist')