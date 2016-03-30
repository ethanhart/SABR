 # Get complete game stats
 # Include IP, SO9 (k/9), others
 
 SELECT playerID, yearID, teamID,
     SO, CG, IPOuts, W, L, GS,
     CG / GS AS CGperGS,
     IPOuts/3 AS IP,
     SO / (IPOuts/3/9) AS SO9,
     (IPOuts/3) / GS AS IperGS
 FROM Pitching
 WHERE yearID > 2000
 HAVING CG > 1 AND GS > 5
 ORDER BY CGperGS DESC
