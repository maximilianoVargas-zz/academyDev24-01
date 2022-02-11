public class EntityPokemonApi {

	public class Black_white {
		public Diamond_pearl animated {get;set;} 
		public String back_default {get;set;} 
		public Object back_female {get;set;} 
		public String back_shiny {get;set;} 
		public Object back_shiny_female {get;set;} 
		public String front_default {get;set;} 
		public Object front_female {get;set;} 
		public String front_shiny {get;set;} 
		public Object front_shiny_female {get;set;} 

		public Black_white(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'animated') {
							animated = new Diamond_pearl(parser);
						} else if (text == 'back_default') {
							back_default = parser.getText();
						} else if (text == 'back_female') {
							back_female = parser.readValueAs(Object.class);
						} else if (text == 'back_shiny') {
							back_shiny = parser.getText();
						} else if (text == 'back_shiny_female') {
							back_shiny_female = parser.readValueAs(Object.class);
						} else if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_female') {
							front_female = parser.readValueAs(Object.class);
						} else if (text == 'front_shiny') {
							front_shiny = parser.getText();
						} else if (text == 'front_shiny_female') {
							front_shiny_female = parser.readValueAs(Object.class);
						} else {
							System.debug(LoggingLevel.WARN, 'Black_white consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Generation_ii {
		public Crystal crystal {get;set;} 
		public Gold gold {get;set;} 
		public Gold silver {get;set;} 

		public Generation_ii(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'crystal') {
							crystal = new Crystal(parser);
						} else if (text == 'gold') {
							gold = new Gold(parser);
						} else if (text == 'silver') {
							silver = new Gold(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Generation_ii consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Types {
		public Integer slot {get;set;} 
		public Ability type {get;set;} 

		public Types(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'slot') {
							slot = parser.getIntegerValue();
						} else if (text == 'type') {
							type = new Ability(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Types consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Firered_leafgreen {
		public String back_default {get;set;} 
		public String back_shiny {get;set;} 
		public String front_default {get;set;} 
		public String front_shiny {get;set;} 

		public Firered_leafgreen(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'back_default') {
							back_default = parser.getText();
						} else if (text == 'back_shiny') {
							back_shiny = parser.getText();
						} else if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_shiny') {
							front_shiny = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Firered_leafgreen consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Generation_iii {
		public Emerald emerald {get;set;} 
		public Firered_leafgreen firered_leafgreen {get;set;} // in json: firered-leafgreen
		public Firered_leafgreen ruby_sapphire {get;set;} // in json: ruby-sapphire

		public Generation_iii(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'emerald') {
							emerald = new Emerald(parser);
						} else if (text == 'firered-leafgreen') {
							firered_leafgreen = new Firered_leafgreen(parser);
						} else if (text == 'ruby-sapphire') {
							ruby_sapphire = new Firered_leafgreen(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Generation_iii consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public List<Abilities> abilities {get;set;} 
	public Integer base_experience {get;set;} 
	public List<Ability> forms {get;set;} 
	public List<Game_indices> game_indices {get;set;} 
	public Integer height {get;set;} 
	public List<Held_items> held_items {get;set;} 
	public Integer id {get;set;} 
	public Boolean is_default {get;set;} 
	public String location_area_encounters {get;set;} 
	public List<Moves> moves {get;set;} 
	public String name {get;set;} 
	public Integer order {get;set;} 
	public List<Past_types> past_types {get;set;} 
	public Ability species {get;set;} 
	public Sprites sprites {get;set;} 
	public List<Stats> stats {get;set;} 
	public List<Types> types {get;set;} 
	public Integer weight {get;set;} 

	public EntityPokemonApi(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'abilities') {
						abilities = arrayOfAbilities(parser);
					} else if (text == 'base_experience') {
						base_experience = parser.getIntegerValue();
					} else if (text == 'forms') {
						forms = arrayOfAbility(parser);
					} else if (text == 'game_indices') {
						game_indices = arrayOfGame_indices(parser);
					} else if (text == 'height') {
						height = parser.getIntegerValue();
					} else if (text == 'held_items') {
						held_items = arrayOfHeld_items(parser);
					} else if (text == 'id') {
						id = parser.getIntegerValue();
					} else if (text == 'is_default') {
						is_default = parser.getBooleanValue();
					} else if (text == 'location_area_encounters') {
						location_area_encounters = parser.getText();
					} else if (text == 'moves') {
						moves = arrayOfMoves(parser);
					} else if (text == 'name') {
						name = parser.getText();
					} else if (text == 'order') {
						order = parser.getIntegerValue();
					} else if (text == 'past_types') {
						past_types = arrayOfPast_types(parser);
					} else if (text == 'species') {
						species = new Ability(parser);
					} else if (text == 'sprites') {
						sprites = new Sprites(parser);
					} else if (text == 'stats') {
						stats = arrayOfStats(parser);
					} else if (text == 'types') {
						types = arrayOfTypes(parser);
					} else if (text == 'weight') {
						weight = parser.getIntegerValue();
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Generation_vii {
		public Dream_world icons {get;set;} 
		public Home ultra_sun_ultra_moon {get;set;} // in json: ultra-sun-ultra-moon

		public Generation_vii(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'icons') {
							icons = new Dream_world(parser);
						} else if (text == 'ultra-sun-ultra-moon') {
							ultra_sun_ultra_moon = new Home(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Generation_vii consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Diamond_pearl {
		public String back_default {get;set;} 
		public Object back_female {get;set;} 
		public String back_shiny {get;set;} 
		public Object back_shiny_female {get;set;} 
		public String front_default {get;set;} 
		public Object front_female {get;set;} 
		public String front_shiny {get;set;} 
		public Object front_shiny_female {get;set;} 

		public Diamond_pearl(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'back_default') {
							back_default = parser.getText();
						} else if (text == 'back_female') {
							back_female = parser.readValueAs(Object.class);
						} else if (text == 'back_shiny') {
							back_shiny = parser.getText();
						} else if (text == 'back_shiny_female') {
							back_shiny_female = parser.readValueAs(Object.class);
						} else if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_female') {
							front_female = parser.readValueAs(Object.class);
						} else if (text == 'front_shiny') {
							front_shiny = parser.getText();
						} else if (text == 'front_shiny_female') {
							front_shiny_female = parser.readValueAs(Object.class);
						} else {
							System.debug(LoggingLevel.WARN, 'Diamond_pearl consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Generation_v {
		public Black_white black_white {get;set;} // in json: black-white

		public Generation_v(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'black-white') {
							black_white = new Black_white(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Generation_v consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Generation_iv {
		public Diamond_pearl diamond_pearl {get;set;} // in json: diamond-pearl
		public Diamond_pearl heartgold_soulsilver {get;set;} // in json: heartgold-soulsilver
		public Diamond_pearl platinum {get;set;} 

		public Generation_iv(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'diamond-pearl') {
							diamond_pearl = new Diamond_pearl(parser);
						} else if (text == 'heartgold-soulsilver') {
							heartgold_soulsilver = new Diamond_pearl(parser);
						} else if (text == 'platinum') {
							platinum = new Diamond_pearl(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Generation_iv consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Moves {
		public Ability move {get;set;} 
		public List<Version_group_details> version_group_details {get;set;} 

		public Moves(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'move') {
							move = new Ability(parser);
						} else if (text == 'version_group_details') {
							version_group_details = arrayOfVersion_group_details(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Moves consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Sprites {
		public String back_default {get;set;} 
		public Object back_female {get;set;} 
		public String back_shiny {get;set;} 
		public Object back_shiny_female {get;set;} 
		public String front_default {get;set;} 
		public Object front_female {get;set;} 
		public String front_shiny {get;set;} 
		public Object front_shiny_female {get;set;} 
		public Other other {get;set;} 
		public Versions versions {get;set;} 

		public Sprites(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'back_default') {
							back_default = parser.getText();
						} else if (text == 'back_female') {
							back_female = parser.readValueAs(Object.class);
						} else if (text == 'back_shiny') {
							back_shiny = parser.getText();
						} else if (text == 'back_shiny_female') {
							back_shiny_female = parser.readValueAs(Object.class);
						} else if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_female') {
							front_female = parser.readValueAs(Object.class);
						} else if (text == 'front_shiny') {
							front_shiny = parser.getText();
						} else if (text == 'front_shiny_female') {
							front_shiny_female = parser.readValueAs(Object.class);
						} else if (text == 'other') {
							other = new Other(parser);
						} else if (text == 'versions') {
							versions = new Versions(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Sprites consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Emerald {
		public String front_default {get;set;} 
		public String front_shiny {get;set;} 

		public Emerald(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_shiny') {
							front_shiny = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Emerald consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Dream_world {
		public String front_default {get;set;} 
		public Object front_female {get;set;} 

		public Dream_world(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_female') {
							front_female = parser.readValueAs(Object.class);
						} else {
							System.debug(LoggingLevel.WARN, 'Dream_world consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Generation_i {
		public Red_blue red_blue {get;set;} // in json: red-blue
		public Red_blue yellow {get;set;} 

		public Generation_i(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'red-blue') {
							red_blue = new Red_blue(parser);
						} else if (text == 'yellow') {
							yellow = new Red_blue(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Generation_i consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Generation_vi {
		public Home omegaruby_alphasapphire {get;set;} // in json: omegaruby-alphasapphire
		public Home x_y {get;set;} // in json: x-y

		public Generation_vi(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'omegaruby-alphasapphire') {
							omegaruby_alphasapphire = new Home(parser);
						} else if (text == 'x-y') {
							x_y = new Home(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Generation_vi consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Home {
		public String front_default {get;set;} 
		public Object front_female {get;set;} 
		public String front_shiny {get;set;} 
		public Object front_shiny_female {get;set;} 

		public Home(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_female') {
							front_female = parser.readValueAs(Object.class);
						} else if (text == 'front_shiny') {
							front_shiny = parser.getText();
						} else if (text == 'front_shiny_female') {
							front_shiny_female = parser.readValueAs(Object.class);
						} else {
							System.debug(LoggingLevel.WARN, 'Home consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Ability {
		public String name {get;set;} 
		public String url {get;set;} 

		public Ability(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'url') {
							url = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Ability consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Gold {
		public String back_default {get;set;} 
		public String back_shiny {get;set;} 
		public String front_default {get;set;} 
		public String front_shiny {get;set;} 
		public String front_transparent {get;set;} 

		public Gold(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'back_default') {
							back_default = parser.getText();
						} else if (text == 'back_shiny') {
							back_shiny = parser.getText();
						} else if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_shiny') {
							front_shiny = parser.getText();
						} else if (text == 'front_transparent') {
							front_transparent = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Gold consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Abilities {
		public Ability ability {get;set;} 
		public Boolean is_hidden {get;set;} 
		public Integer slot {get;set;} 

		public Abilities(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'ability') {
							ability = new Ability(parser);
						} else if (text == 'is_hidden') {
							is_hidden = parser.getBooleanValue();
						} else if (text == 'slot') {
							slot = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Abilities consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Version_details {
		public Integer rarity {get;set;} 
		public Ability version {get;set;} 

		public Version_details(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'rarity') {
							rarity = parser.getIntegerValue();
						} else if (text == 'version') {
							version = new Ability(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Version_details consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Red_blue {
		public String back_default {get;set;} 
		public String back_gray {get;set;} 
		public String back_transparent {get;set;} 
		public String front_default {get;set;} 
		public String front_gray {get;set;} 
		public String front_transparent {get;set;} 

		public Red_blue(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'back_default') {
							back_default = parser.getText();
						} else if (text == 'back_gray') {
							back_gray = parser.getText();
						} else if (text == 'back_transparent') {
							back_transparent = parser.getText();
						} else if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_gray') {
							front_gray = parser.getText();
						} else if (text == 'front_transparent') {
							front_transparent = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Red_blue consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Game_indices {
		public Integer game_index {get;set;} 
		public Ability version {get;set;} 

		public Game_indices(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'game_index') {
							game_index = parser.getIntegerValue();
						} else if (text == 'version') {
							version = new Ability(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Game_indices consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Official_artwork {
		public String front_default {get;set;} 

		public Official_artwork(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'front_default') {
							front_default = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Official_artwork consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Version_group_details {
		public Integer level_learned_at {get;set;} 
		public Ability move_learn_method {get;set;} 
		public Ability version_group {get;set;} 

		public Version_group_details(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'level_learned_at') {
							level_learned_at = parser.getIntegerValue();
						} else if (text == 'move_learn_method') {
							move_learn_method = new Ability(parser);
						} else if (text == 'version_group') {
							version_group = new Ability(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Version_group_details consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Versions {
		public Generation_i generation_i {get;set;} // in json: generation-i
		public Generation_ii generation_ii {get;set;} // in json: generation-ii
		public Generation_iii generation_iii {get;set;} // in json: generation-iii
		public Generation_iv generation_iv {get;set;} // in json: generation-iv
		public Generation_v generation_v {get;set;} // in json: generation-v
		public Generation_vi generation_vi {get;set;} // in json: generation-vi
		public Generation_vii generation_vii {get;set;} // in json: generation-vii
		public Generation_viii generation_viii {get;set;} // in json: generation-viii

		public Versions(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'generation-i') {
							generation_i = new Generation_i(parser);
						} else if (text == 'generation-ii') {
							generation_ii = new Generation_ii(parser);
						} else if (text == 'generation-iii') {
							generation_iii = new Generation_iii(parser);
						} else if (text == 'generation-iv') {
							generation_iv = new Generation_iv(parser);
						} else if (text == 'generation-v') {
							generation_v = new Generation_v(parser);
						} else if (text == 'generation-vi') {
							generation_vi = new Generation_vi(parser);
						} else if (text == 'generation-vii') {
							generation_vii = new Generation_vii(parser);
						} else if (text == 'generation-viii') {
							generation_viii = new Generation_viii(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Versions consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Stats {
		public Integer base_stat {get;set;} 
		public Integer effort {get;set;} 
		public Ability stat {get;set;} 

		public Stats(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'base_stat') {
							base_stat = parser.getIntegerValue();
						} else if (text == 'effort') {
							effort = parser.getIntegerValue();
						} else if (text == 'stat') {
							stat = new Ability(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Stats consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Held_items {
		public Ability item {get;set;} 
		public List<Version_details> version_details {get;set;} 

		public Held_items(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'item') {
							item = new Ability(parser);
						} else if (text == 'version_details') {
							version_details = arrayOfVersion_details(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Held_items consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Generation_viii {
		public Dream_world icons {get;set;} 

		public Generation_viii(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'icons') {
							icons = new Dream_world(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Generation_viii consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Past_types {

		public Past_types(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						{
							System.debug(LoggingLevel.WARN, 'Past_types consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Other {
		public Dream_world dream_world {get;set;} 
		public Home home {get;set;} 
		public Official_artwork official_artwork {get;set;} // in json: official-artwork

		public Other(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'dream_world') {
							dream_world = new Dream_world(parser);
						} else if (text == 'home') {
							home = new Home(parser);
						} else if (text == 'official-artwork') {
							official_artwork = new Official_artwork(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Other consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Crystal {
		public String back_default {get;set;} 
		public String back_shiny {get;set;} 
		public String back_shiny_transparent {get;set;} 
		public String back_transparent {get;set;} 
		public String front_default {get;set;} 
		public String front_shiny {get;set;} 
		public String front_shiny_transparent {get;set;} 
		public String front_transparent {get;set;} 

		public Crystal(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'back_default') {
							back_default = parser.getText();
						} else if (text == 'back_shiny') {
							back_shiny = parser.getText();
						} else if (text == 'back_shiny_transparent') {
							back_shiny_transparent = parser.getText();
						} else if (text == 'back_transparent') {
							back_transparent = parser.getText();
						} else if (text == 'front_default') {
							front_default = parser.getText();
						} else if (text == 'front_shiny') {
							front_shiny = parser.getText();
						} else if (text == 'front_shiny_transparent') {
							front_shiny_transparent = parser.getText();
						} else if (text == 'front_transparent') {
							front_transparent = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Crystal consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static EntityPokemonApi parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new EntityPokemonApi(parser);
	}

    
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	

    private static List<Game_indices> arrayOfGame_indices(System.JSONParser p) {
        List<Game_indices> res = new List<Game_indices>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Game_indices(p));
        }
        return res;
    }




    private static List<Ability> arrayOfAbility(System.JSONParser p) {
        List<Ability> res = new List<Ability>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Ability(p));
        }
        return res;
    }





    private static List<Moves> arrayOfMoves(System.JSONParser p) {
        List<Moves> res = new List<Moves>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Moves(p));
        }
        return res;
    }





    private static List<Version_details> arrayOfVersion_details(System.JSONParser p) {
        List<Version_details> res = new List<Version_details>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Version_details(p));
        }
        return res;
    }




    private static List<Abilities> arrayOfAbilities(System.JSONParser p) {
        List<Abilities> res = new List<Abilities>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Abilities(p));
        }
        return res;
    }


    private static List<Version_group_details> arrayOfVersion_group_details(System.JSONParser p) {
        List<Version_group_details> res = new List<Version_group_details>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Version_group_details(p));
        }
        return res;
    }




    private static List<Stats> arrayOfStats(System.JSONParser p) {
        List<Stats> res = new List<Stats>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Stats(p));
        }
        return res;
    }




    private static List<Held_items> arrayOfHeld_items(System.JSONParser p) {
        List<Held_items> res = new List<Held_items>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Held_items(p));
        }
        return res;
    }

    private static List<Types> arrayOfTypes(System.JSONParser p) {
        List<Types> res = new List<Types>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Types(p));
        }
        return res;
    }


    private static List<Past_types> arrayOfPast_types(System.JSONParser p) {
        List<Past_types> res = new List<Past_types>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Past_types(p));
        }
        return res;
    }

	public static string JsonPokemon(){
		String json = '{'+
		'  \"abilities\": ['+
		'    {'+
		'      \"ability\": {'+
		'        \"name\": \"limber\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/ability/7/\"'+
		'      },'+
		'      \"is_hidden\": false,'+
		'      \"slot\": 1'+
		'    },'+
		'    {'+
		'      \"ability\": {'+
		'        \"name\": \"imposter\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/ability/150/\"'+
		'      },'+
		'      \"is_hidden\": true,'+
		'      \"slot\": 3'+
		'    }'+
		'  ],'+
		'  \"base_experience\": 101,'+
		'  \"forms\": ['+
		'    {'+
		'      \"name\": \"ditto\",'+
		'      \"url\": \"https://pokeapi.co/api/v2/pokemon-form/132/\"'+
		'    }'+
		'  ],'+
		'  \"game_indices\": ['+
		'    {'+
		'      \"game_index\": 76,'+
		'      \"version\": {'+
		'        \"name\": \"red\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/1/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 76,'+
		'      \"version\": {'+
		'        \"name\": \"blue\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/2/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 76,'+
		'      \"version\": {'+
		'        \"name\": \"yellow\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/3/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"gold\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/4/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"silver\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/5/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"crystal\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/6/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"ruby\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/7/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"sapphire\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/8/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"emerald\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/9/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"firered\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/10/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"leafgreen\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/11/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"diamond\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/12/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"pearl\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/13/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"platinum\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/14/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"heartgold\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/15/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"soulsilver\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/16/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"black\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/17/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"white\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/18/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"black-2\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/21/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"game_index\": 132,'+
		'      \"version\": {'+
		'        \"name\": \"white-2\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/version/22/\"'+
		'      }'+
		'    }'+
		'  ],'+
		'  \"height\": 3,'+
		'  \"held_items\": ['+
		'    {'+
		'      \"item\": {'+
		'        \"name\": \"metal-powder\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/item/234/\"'+
		'      },'+
		'      \"version_details\": ['+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"ruby\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/7/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"sapphire\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/8/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"emerald\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/9/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"firered\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/10/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"leafgreen\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/11/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"diamond\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/12/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"pearl\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/13/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"platinum\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/14/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"heartgold\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/15/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"soulsilver\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/16/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"black\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/17/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"white\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/18/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"black-2\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/21/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"white-2\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/22/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"x\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/23/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"y\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/24/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"omega-ruby\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/25/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"alpha-sapphire\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/26/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"sun\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/27/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"moon\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/28/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"ultra-sun\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/29/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 5,'+
		'          \"version\": {'+
		'            \"name\": \"ultra-moon\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/30/\"'+
		'          }'+
		'        }'+
		'      ]'+
		'    },'+
		'    {'+
		'      \"item\": {'+
		'        \"name\": \"quick-powder\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/item/251/\"'+
		'      },'+
		'      \"version_details\": ['+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"diamond\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/12/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"pearl\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/13/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"platinum\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/14/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"heartgold\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/15/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"soulsilver\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/16/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"black\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/17/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"white\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/18/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"black-2\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/21/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"white-2\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/22/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"x\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/23/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"y\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/24/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"omega-ruby\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/25/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"alpha-sapphire\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/26/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"sun\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/27/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"moon\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/28/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"ultra-sun\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/29/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"rarity\": 50,'+
		'          \"version\": {'+
		'            \"name\": \"ultra-moon\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version/30/\"'+
		'          }'+
		'        }'+
		'      ]'+
		'    }'+
		'  ],'+
		'  \"id\": 132,'+
		'  \"is_default\": true,'+
		'  \"location_area_encounters\": \"https://pokeapi.co/api/v2/pokemon/132/encounters\",'+
		'  \"moves\": ['+
		'    {'+
		'      \"move\": {'+
		'        \"name\": \"transform\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/move/144/\"'+
		'      },'+
		'      \"version_group_details\": ['+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"red-blue\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/1/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"yellow\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/2/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"gold-silver\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/3/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"crystal\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/4/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"ruby-sapphire\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/5/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"emerald\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/6/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"firered-leafgreen\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/7/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"diamond-pearl\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/8/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"platinum\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/9/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"heartgold-soulsilver\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/10/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"black-white\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/11/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"colosseum\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/12/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"xd\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/13/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"black-2-white-2\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/14/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"x-y\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/15/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"omega-ruby-alpha-sapphire\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/16/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"sun-moon\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/17/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"ultra-sun-ultra-moon\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/18/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"lets-go-pikachu-lets-go-eevee\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/19/\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"level_learned_at\": 1,'+
		'          \"move_learn_method\": {'+
		'            \"name\": \"level-up\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/move-learn-method/1/\"'+
		'          },'+
		'          \"version_group\": {'+
		'            \"name\": \"sword-shield\",'+
		'            \"url\": \"https://pokeapi.co/api/v2/version-group/20/\"'+
		'          }'+
		'        }'+
		'      ]'+
		'    }'+
		'  ],'+
		'  \"name\": \"ditto\",'+
		'  \"order\": 214,'+
		'  \"past_types\": [],'+
		'  \"species\": {'+
		'    \"name\": \"ditto\",'+
		'    \"url\": \"https://pokeapi.co/api/v2/pokemon-species/132/\"'+
		'  },'+
		'  \"sprites\": {'+
		'    \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png\",'+
		'    \"back_female\": null,'+
		'    \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/132.png\",'+
		'    \"back_shiny_female\": null,'+
		'    \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png\",'+
		'    \"front_female\": null,'+
		'    \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/132.png\",'+
		'    \"front_shiny_female\": null,'+
		'    \"other\": {'+
		'      \"dream_world\": {'+
		'        \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/132.svg\",'+
		'        \"front_female\": null'+
		'      },'+
		'      \"home\": {'+
		'        \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/132.png\",'+
		'        \"front_female\": null,'+
		'        \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/132.png\",'+
		'        \"front_shiny_female\": null'+
		'      },'+
		'      \"official-artwork\": {'+
		'        \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png\"'+
		'      }'+
		'    },'+
		'    \"versions\": {'+
		'      \"generation-i\": {'+
		'        \"red-blue\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/back/132.png\",'+
		'          \"back_gray\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/back/gray/132.png\",'+
		'          \"back_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/transparent/back/132.png\",'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/132.png\",'+
		'          \"front_gray\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/gray/132.png\",'+
		'          \"front_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/transparent/132.png\"'+
		'        },'+
		'        \"yellow\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/back/132.png\",'+
		'          \"back_gray\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/back/gray/132.png\",'+
		'          \"back_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/transparent/back/132.png\",'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/132.png\",'+
		'          \"front_gray\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/gray/132.png\",'+
		'          \"front_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/transparent/132.png\"'+
		'        }'+
		'      },'+
		'      \"generation-ii\": {'+
		'        \"crystal\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/back/132.png\",'+
		'          \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/back/shiny/132.png\",'+
		'          \"back_shiny_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/back/shiny/132.png\",'+
		'          \"back_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/back/132.png\",'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/132.png\",'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/shiny/132.png\",'+
		'          \"front_shiny_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/shiny/132.png\",'+
		'          \"front_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/132.png\"'+
		'        },'+
		'        \"gold\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/back/132.png\",'+
		'          \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/back/shiny/132.png\",'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/132.png\",'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/shiny/132.png\",'+
		'          \"front_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/transparent/132.png\"'+
		'        },'+
		'        \"silver\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/back/132.png\",'+
		'          \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/back/shiny/132.png\",'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/132.png\",'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/shiny/132.png\",'+
		'          \"front_transparent\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/transparent/132.png\"'+
		'        }'+
		'      },'+
		'      \"generation-iii\": {'+
		'        \"emerald\": {'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/132.png\",'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/shiny/132.png\"'+
		'        },'+
		'        \"firered-leafgreen\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/firered-leafgreen/back/132.png\",'+
		'          \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/firered-leafgreen/back/shiny/132.png\",'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/firered-leafgreen/132.png\",'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/firered-leafgreen/shiny/132.png\"'+
		'        },'+
		'        \"ruby-sapphire\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/ruby-sapphire/back/132.png\",'+
		'          \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/ruby-sapphire/back/shiny/132.png\",'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/ruby-sapphire/132.png\",'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/ruby-sapphire/shiny/132.png\"'+
		'        }'+
		'      },'+
		'      \"generation-iv\": {'+
		'        \"diamond-pearl\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/back/132.png\",'+
		'          \"back_female\": null,'+
		'          \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/back/shiny/132.png\",'+
		'          \"back_shiny_female\": null,'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/132.png\",'+
		'          \"front_female\": null,'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/shiny/132.png\",'+
		'          \"front_shiny_female\": null'+
		'        },'+
		'        \"heartgold-soulsilver\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/back/132.png\",'+
		'          \"back_female\": null,'+
		'          \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/back/shiny/132.png\",'+
		'          \"back_shiny_female\": null,'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/132.png\",'+
		'          \"front_female\": null,'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/shiny/132.png\",'+
		'          \"front_shiny_female\": null'+
		'        },'+
		'        \"platinum\": {'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/platinum/back/132.png\",'+
		'          \"back_female\": null,'+
		'          \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/platinum/back/shiny/132.png\",'+
		'          \"back_shiny_female\": null,'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/platinum/132.png\",'+
		'          \"front_female\": null,'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/platinum/shiny/132.png\",'+
		'          \"front_shiny_female\": null'+
		'        }'+
		'      },'+
		'      \"generation-v\": {'+
		'        \"black-white\": {'+
		'          \"animated\": {'+
		'            \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/back/132.gif\",'+
		'            \"back_female\": null,'+
		'            \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/back/shiny/132.gif\",'+
		'            \"back_shiny_female\": null,'+
		'            \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/132.gif\",'+
		'            \"front_female\": null,'+
		'            \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/shiny/132.gif\",'+
		'            \"front_shiny_female\": null'+
		'          },'+
		'          \"back_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/back/132.png\",'+
		'          \"back_female\": null,'+
		'          \"back_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/back/shiny/132.png\",'+
		'          \"back_shiny_female\": null,'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/132.png\",'+
		'          \"front_female\": null,'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/shiny/132.png\",'+
		'          \"front_shiny_female\": null'+
		'        }'+
		'      },'+
		'      \"generation-vi\": {'+
		'        \"omegaruby-alphasapphire\": {'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/132.png\",'+
		'          \"front_female\": null,'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/shiny/132.png\",'+
		'          \"front_shiny_female\": null'+
		'        },'+
		'        \"x-y\": {'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/x-y/132.png\",'+
		'          \"front_female\": null,'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/x-y/shiny/132.png\",'+
		'          \"front_shiny_female\": null'+
		'        }'+
		'      },'+
		'      \"generation-vii\": {'+
		'        \"icons\": {'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/icons/132.png\",'+
		'          \"front_female\": null'+
		'        },'+
		'        \"ultra-sun-ultra-moon\": {'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/132.png\",'+
		'          \"front_female\": null,'+
		'          \"front_shiny\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/shiny/132.png\",'+
		'          \"front_shiny_female\": null'+
		'        }'+
		'      },'+
		'      \"generation-viii\": {'+
		'        \"icons\": {'+
		'          \"front_default\": \"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/132.png\",'+
		'          \"front_female\": null'+
		'        }'+
		'      }'+
		'    }'+
		'  },'+
		'  \"stats\": ['+
		'    {'+
		'      \"base_stat\": 48,'+
		'      \"effort\": 1,'+
		'      \"stat\": {'+
		'        \"name\": \"hp\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/stat/1/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"base_stat\": 48,'+
		'      \"effort\": 0,'+
		'      \"stat\": {'+
		'        \"name\": \"attack\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/stat/2/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"base_stat\": 48,'+
		'      \"effort\": 0,'+
		'      \"stat\": {'+
		'        \"name\": \"defense\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/stat/3/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"base_stat\": 48,'+
		'      \"effort\": 0,'+
		'      \"stat\": {'+
		'        \"name\": \"special-attack\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/stat/4/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"base_stat\": 48,'+
		'      \"effort\": 0,'+
		'      \"stat\": {'+
		'        \"name\": \"special-defense\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/stat/5/\"'+
		'      }'+
		'    },'+
		'    {'+
		'      \"base_stat\": 48,'+
		'      \"effort\": 0,'+
		'      \"stat\": {'+
		'        \"name\": \"speed\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/stat/6/\"'+
		'      }'+
		'    }'+
		'  ],'+
		'  \"types\": ['+
		'    {'+
		'      \"slot\": 1,'+
		'      \"type\": {'+
		'        \"name\": \"normal\",'+
		'        \"url\": \"https://pokeapi.co/api/v2/type/1/\"'+
		'      }'+
		'    }'+
		'  ],'+
		'  \"weight\": 40'+
		'}';

		return json;
	}
}