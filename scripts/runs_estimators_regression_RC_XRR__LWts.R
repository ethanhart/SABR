fname = file.choose()
Teams = read.csv(fname)
summary(Teams)
attach(Teams)

# Calculate Runs Estimators|
#--------------------------+

# Total Bases
TB = (H + X2B + 2*X3B + 3*HR)

# Slugging
SLG = TB / AB

# On-base Percentage
OBP = (H + BB + HBP) / (AB + BB + HBP + SF)

# On-base Plus Slugging
OPS = SLG + OBP

# Batter Run Average
BRA = SLG * OBP

# Adjusted OPS
ADJ_OPS = OBP * 1.8 + SLG

# Runs Created (Basic) (Bill James)
RCB = (TB*(H + BB)) / (AB + BB)

# Extrapolated Runs Reduced (Jim Furtado)
XRR = (.5*(H-HR-X3B-X2B)) + (.72*X2B) + (1.04*X3B) + (1.44*HR) + .33*(HBP + BB) + .18*(SB) - .32*CS - .098*(AB-H)

# Linear Weights (Pete Palmer)
LWTs = (.46*(H-HR-X3B-X2B)) + (.8*X2B) + (1.02*X3B) + (1.4*HR) + .33*(HBP + BB) + .3*(SB) - .6*CS - .25*(AB-H) + 701.2

Teams["RCB"] = RCB
Teams["XRR"] = XRR
Teams["LWT"] = LWTs

# Columns for scatterplot
Teams_runs_est = Teams[c("R", "RCB", "XRR", "LWT")]
#View(Teams_runs_est)
splom(Teams_runs_est, xlab = "Team Runs Estimators")

RvRCB = lm(R ~ RCB)
plot(R, RCB)
abline(RvRCB)
summary(RvRCB)$r.squared
cor(R,RCB)

RvXRR = lm(R ~ XRR)
plot(R, XRR)
abline(RvXRR)
summary(RvXRR)$r.squared
cor(R,XRR)

RvLWT = lm(Teams$LWT ~ Teams$R)
plot(Teams$R, Teams$LWT)
abline(RvLWT)
summary(RvLWT)$r.squared
cor(Teams$R, Teams$LWT)
