# PokeApi
Simple app to use Alamofire, Kingfisher and SwiftyJSON to access Pokémon data from PokeApi.co
Having done some basic JSON parsing in the "Smack" training app, I wanted to understand it in greater detail so I made this.

What making  this app has taught me:
1) How to successfully parse more complicated JSON objects using SwiftyJSON and .map
2) Best practice: having an enum that lists the various parameters for the JSON objects you are using makes things a lot simpler both to code and read.  It also allows you to update a parameter once if the API changes, rather than having to go through your whole code looking for strings.
3) Making a custom UITableView to populate from the results of a JSON object.  
