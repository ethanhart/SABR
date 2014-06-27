// Query which produces several win estimators
// From Andy Andres SABR101x
//
// SELECT yearID, teamID
//    , R , RA
//    , R / (W + L) AS RperG
//    , RA / (W + L) AS RAperG   
//    , W , L
//    , W / (W + L) AS WPct
//    , .484 * (R/RA) AS Cook_WPct
//    , (.102 * R / (W + L)) - (.103 * RA / (W + L)) + .505 AS Soolman_WPct
//    , IF(R > RA, R/(2*RA), (1 - RA/(2*R))) AS Kross_WPct 
//    , (R-RA)/(R+RA) + .5 AS Smyth_WPct 
//    , POW(R,2) / (POW(R,2) + POW(RA,2)) AS BJames_Pythag_WPct
//    , POW(R,1.83) / (POW(R,1.83) + POW(RA,1.83)) AS BJames_Pythag_WPctII
// FROM Teams 
// WHERE yearID > 1901
//       ORDER BY WPct DESC

win <- read.csv("win_estimators.csv")
estimators <- win[c('WPct', 'Cook_WPct', 'Soolman_WPct', 'Kross_WPct', 'Smyth_WPct', 'BJames_Pythag_WPct', 'BJames_Pythag_WPctII')]
require('lattice')

#plot(win$WPct, win$Smyth_WPct, xlab = "Actual Wpct", ylab = "Smyth Predicted WPct", pch = 18, col = "red")
splom(estimators)
