# Mission Notes for Dynamic Campaign in Arma 3 

## Tasks to complete
### AI Logic - How to use Pathways
https://community.bistudio.com/wiki/calculatePath
https://community.bistudio.com/wiki/BIS_fnc_moveMarker

*Utilize these two in order to move units around the map without using up system performance.*

Need to remove TRIGGERS!! Use Markers instead! 

### Utilize hashmaps in order to hold data instead of arrays. BIG performance boost.
https://gemini.google.com/app/d72f22ac926d552e

Utilize HASH MAP as the RAM and only save occassionally (15 minutes or so). 
Use INIDBI for initial load and occasional save. Not for gathering of data. 
Use HASHMAP with Marker ID in order to add a new item to the hashmap. 
- This can also include any / all data that the marker would have had through Variables before

### Theory
- Load DB > Set into Hashmap > All game logic uses HASH > Save routinely
- No more Triggers > Use Map Markers > Use Hashmap's referencing Marker ID > Check for near players. 