-- This module contains code for all Italian conjugation templates.
-- Function itconj generates the pretty table using parameters passed from the templates and their invocation

p = {}

function p.itconj(frame)
    pframe = frame:getParent()
    config = frame.args
    args = pframe.args
-- Get basic info from template invocation
    stem = args[1]
    aus = args[3] or " "
-- Initialize all variables that might otherwise be null
    inf = ""
    ger = ""
    par= ""
    pp = ""
    pres1s = ""
    pres1s2 = ""
    pres2s="";
    pres3s = "";
    pres1p = "";
    pres2p = "";
    pres3p = ""
    imperf1s = "";
    imperf2s="";
    imperf3s = "";
    imperf1p = "";
    imperf2p = "";
    imperf3p = ""
    prem1s = "";
    prem2s = "";
    prem3s = "";
    prem3s2 = "";
    prem1p = "";
    prem2p = "";
    prem3p = "";
    prem3p2 = ""
    fut1s = "";
    fut2s="";
    fut3s = "";
    fut1p =" ";
    fut2p = "";
    fut3p = ""
    cond1s = "";
    cond2s="";
    cond3s = "";
    cond1p = "";
    cond2p = "";
    cond3p = ""
    cong123s = "";
    cong3s = nil;
    cong1p = "";
    cong2p = "";
    cong3p = ""
    congimp12s = "";
    congimp3s = "";
    congimp1p = "";
    congimp2p = "";
    congimp3p = ""
    imp2s="";
    imp2s2 = "";
    imp2s3 = "";
    imp3s = "";
    imp1p = "";
    imp2p = "";
    imp3p = ""
    mi = "";
    ti = "";
    si = "";
    ci = "";
    vi = ""
 -- Find what type of verb is it (hard-coded in the template).
 -- Generate standard conjugated forms for each type of verb,
     type = config["type"]
     if type == nil then
	 inf = p.wiki(args["inf"])
     elseif (type == "are") or (type == "arsi") then
	 inf = p.wiki(stem .. "are")
	 ger = p.wiki(stem .. "ando");
	 par = p.wiki(stem .. "ante");
	 pp = p.wiki(stem .. "ato")
	 pres1s = p.wiki(stem .. "o");
	 pres2s = p.wiki(stem .. "i");
	 pres3s = p.wiki(stem .. "a")
	 pres1p = p.wiki(stem .. "iamo");
	 pres2p = p.wiki(stem .. "ate");
	 pres3p = p.wiki(stem .. "ano")
	 imperf1s = p.wiki(stem .. "avo");
	 imperf2s = p.wiki(stem .. "avi");
	 imperf3s = p.wiki(stem .. "ava")
	 imperf1p = p.wiki(stem .. "avamo");
	 imperf2p = p.wiki(stem .. "avate");
	 imperf3p = p.wiki(stem .. "avano")
	 prem1s = p.wiki(stem .. "ai");
	 prem2s = p.wiki(stem .. "asti");
	 prem3s = p.wiki(stem .. "ò")
	 prem1p = p.wiki(stem .. "ammo");
	 prem2p = p.wiki(stem .. "aste");
	 prem3p = p.wiki(stem .. "arono")
	 fut1s = p.wiki(stem .. "erò");
	 fut2s = p.wiki(stem .. "erai");
	 fut3s = p.wiki(stem .. "erà")
	 fut1p = p.wiki(stem .. "eremo");
	 fut2p = p.wiki(stem .. "erete");
	 fut3p = p.wiki(stem .. "eranno")
	 cond1s = p.wiki(stem .. "erei");
	 cond2s = p.wiki(stem .. "eresti");
	 cond3s = p.wiki(stem .. "erebbe")
	 cond1p = p.wiki(stem .. "eremmo");
	 cond2p = p.wiki(stem .. "ereste");
	 cond3p = p.wiki(stem .. "erebbero")
	 cong123s = p.wiki(stem .. "i");
	 cong3s = nil
	 cong1p = p.wiki(stem .. "iamo");
	 cong2p = p.wiki(stem .. "iate");
	 cong3p = p.wiki(stem .. "ino")
	 congimp12s = p.wiki(stem .. "assi");
	 congimp3s = p.wiki(stem .. "asse")
	 congimp1p = p.wiki(stem .. "assimo");
	 congimp2p = p.wiki(stem .. "aste");
	 congimp3p = p.wiki(stem .. "assero")
	 imp2s = p.wiki(stem .. "a");
	 imp3s = p.wiki(stem .. "i")
	 imp1p = p.wiki(stem .. "iamo");
	 imp2p = p.wiki(stem .. "ate");
	 imp3p = p.wiki(stem .. "ino")
     elseif (type == "care") or (type == "carsi") or (type == "gare") or (type == "garsi") then
	 inf = p.wiki(stem .. "are")
	 ger = p.wiki(stem .. "ando");
	 par = p.wiki(stem .. "ante");
	 pp = p.wiki(stem .. "ato")
	 pres1s = p.wiki(stem .. "o");
	 pres2s = p.wiki(stem .. "hi");
	 pres3s = p.wiki(stem .. "a")
	 pres1p = p.wiki(stem .. "hiamo");
	 pres2p = p.wiki(stem .. "ate");
	 pres3p = p.wiki(stem .. "ano")
	 imperf1s = p.wiki(stem .. "avo");
	 imperf2s = p.wiki(stem .. "avi");
	 imperf3s = p.wiki(stem .. "ava")
	 imperf1p = p.wiki(stem .. "avamo");
	 imperf2p = p.wiki(stem .. "avate");
	 imperf3p = p.wiki(stem .. "avano")
	 prem1s = p.wiki(stem .. "ai");  prem2s = p.wiki(stem .. "asti");  prem3s = p.wiki(stem .. "ò")
	 prem1p = p.wiki(stem .. "ammo");  prem2p = p.wiki(stem .. "aste");  prem3p = p.wiki(stem .. "arono") 
	 fut1s = p.wiki(stem .. "herò");  fut2s = p.wiki(stem .. "herai");  fut3s = p.wiki(stem .. "herà")
	 fut1p = p.wiki(stem .. "heremo");  fut2p = p.wiki(stem .. "herete");  fut3p = p.wiki(stem .. "heranno") 
	 cond1s = p.wiki(stem .. "herei");  cond2s = p.wiki(stem .. "heresti");  cond3s = p.wiki(stem .. "herebbe")
	 cond1p = p.wiki(stem .. "heremmo");  cond2p = p.wiki(stem .. "hereste");  cond3p = p.wiki(stem .. "herebbero") 
	 cong123s = p.wiki(stem .. "hi"); cong3s = nil
	 cong1p = p.wiki(stem .. "hiamo");  cong2p = p.wiki(stem .. "hiate");  cong3p = p.wiki(stem .. "hino")
	 congimp12s = p.wiki(stem .. "assi");  congimp3s = p.wiki(stem .. "asse")
	 congimp1p = p.wiki(stem .. "assimo");  congimp2p = p.wiki(stem .. "aste");  congimp3p = p.wiki(stem .. "assero")
	 imp2s = p.wiki(stem .. "a");  imp3s = p.wiki(stem .. "hi")
	 imp1p = p.wiki(stem .. "hiamo");  imp2p = p.wiki(stem .. "ate");  imp3p = p.wiki(stem .. "hino")        
     elseif (type == "ere") or (type == "ersi") then
	 inf = p.wiki(stem .. "ere")
	 ger = p.wiki(stem .. "endo");  par = p.wiki(stem .. "ente");  pp = p.wiki(stem .. "uto")
	 pres1s = p.wiki(stem .. "o");  pres2s = p.wiki(stem .. "i");  pres3s = p.wiki(stem .. "e")
	 pres1p = p.wiki(stem .. "iamo");  pres2p = p.wiki(stem .. "ete");  pres3p = p.wiki(stem .. "ono")        
	 imperf1s = p.wiki(stem .. "evo");  imperf2s = p.wiki(stem .. "evi");  imperf3s = p.wiki(stem .. "eva")
	 imperf1p = p.wiki(stem .. "evamo");  imperf2p = p.wiki(stem .. "evate");  imperf3p = p.wiki(stem .. "evano") 
	 prem1s = p.wiki(stem .. "ei");  prem2s = p.wiki(stem .. "esti");  prem3s = p.wiki(stem .. "ette"); prem3s2 = p.wiki(stem .. "é")
	 prem1p = p.wiki(stem .. "emmo");  prem2p = p.wiki(stem .. "este");  prem3p = p.wiki(stem .. "ettero"); prem3p2 = p.wiki(stem .. "erono") 
	 fut1s = p.wiki(stem .. "erò");  fut2s = p.wiki(stem .. "erai");  fut3s = p.wiki(stem .. "erà")
	 fut1p = p.wiki(stem .. "eremo");  fut2p = p.wiki(stem .. "erete");  fut3p = p.wiki(stem .. "eranno") 
	 cond1s = p.wiki(stem .. "erei");  cond2s = p.wiki(stem .. "eresti");  cond3s = p.wiki(stem .. "erebbe")
	 cond1p = p.wiki(stem .. "eremmo");  cond2p = p.wiki(stem .. "ereste");  cond3p = p.wiki(stem .. "erebbero") 
	 cong123s = p.wiki(stem .. "a"); cong3s = nil
	 cong1p = p.wiki(stem .. "iamo");  cong2p = p.wiki(stem .. "iate");  cong3p = p.wiki(stem .. "ano")
	 congimp12s = p.wiki(stem .. "essi");  congimp3s = p.wiki(stem .. "esse")
	 congimp1p = p.wiki(stem .. "essimo");  congimp2p = p.wiki(stem .. "este");  congimp3p = p.wiki(stem .. "essero")
	 imp2s = p.wiki(stem .. "i");  imp3s = p.wiki(stem .. "i")
	 imp1p = p.wiki(stem .. "iamo");  imp2p = p.wiki(stem .. "ete");  imp3p = p.wiki(stem .. "ano")
     elseif (type == "ire-b") or (type == "irsi-b") then
	 inf = p.wiki(stem .. "ire")
	 ger = p.wiki(stem .. "endo");  par = p.wiki(stem .. "ente");  pp = p.wiki(stem .. "ito")
	 pres1s = p.wiki(stem .. "isco");  pres2s = p.wiki(stem .. "isci");  pres3s = p.wiki(stem .. "isce")
	 pres1p = p.wiki(stem .. "iamo");  pres2p = p.wiki(stem .. "ite");  pres3p = p.wiki(stem .. "iscono")        
	 imperf1s = p.wiki(stem .. "ivo");  imperf2s = p.wiki(stem .. "ivi");  imperf3s = p.wiki(stem .. "iva")
	 imperf1p = p.wiki(stem .. "ivamo");  imperf2p = p.wiki(stem .. "ivate");  imperf3p = p.wiki(stem .. "ivano") 
	 prem1s = p.wiki(stem .. "ii");  prem2s = p.wiki(stem .. "isti");  prem3s = p.wiki(stem .. "ì")
	 prem1p = p.wiki(stem .. "immo");  prem2p = p.wiki(stem .. "iste");  prem3p = p.wiki(stem .. "irono") 
	 fut1s = p.wiki(stem .. "irò");  fut2s = p.wiki(stem .. "irai");  fut3s = p.wiki(stem .. "irà")
	 fut1p = p.wiki(stem .. "iremo");  fut2p = p.wiki(stem .. "irete");  fut3p = p.wiki(stem .. "iranno") 
	 cond1s = p.wiki(stem .. "irei");  cond2s = p.wiki(stem .. "iresti");  cond3s = p.wiki(stem .. "irebbe")
	 cond1p = p.wiki(stem .. "iremmo");  cond2p = p.wiki(stem .. "ireste");  cond3p = p.wiki(stem .. "irebbero") 
	 cong123s = p.wiki(stem .. "isca"); cong3s = nil
	 cong1p = p.wiki(stem .. "iamo");  cong2p = p.wiki(stem .. "iate");  cong3p = p.wiki(stem .. "iscano")
	 congimp12s = p.wiki(stem .. "issi");  congimp3s = p.wiki(stem .. "isse")
	 congimp1p = p.wiki(stem .. "issimo");  congimp2p = p.wiki(stem .. "iste");  congimp3p = p.wiki(stem .. "issero")
	 imp2s = p.wiki(stem .. "isci");  imp3s = p.wiki(stem .. "isca")
	 imp1p = p.wiki(stem .. "iamo");  imp2p = p.wiki(stem .. "ite");  imp3p = p.wiki(stem .. "iscano")        
     elseif (type == "ire") or (type == "irsi") then
	 inf = p.wiki(stem .. "ire")
	 ger = p.wiki(stem .. "endo");  par = p.wiki(stem .. "ente");  pp = p.wiki(stem .. "ito")
	 pres1s = p.wiki(stem .. "o");  pres2s = p.wiki(stem .. "i");  pres3s = p.wiki(stem .. "e")
	 pres1p = p.wiki(stem .. "iamo");  pres2p = p.wiki(stem .. "ite");  pres3p = p.wiki(stem .. "ono")        
	 imperf1s = p.wiki(stem .. "ivo");  imperf2s = p.wiki(stem .. "ivi");  imperf3s = p.wiki(stem .. "iva")
	 imperf1p = p.wiki(stem .. "ivamo");  imperf2p = p.wiki(stem .. "ivate");  imperf3p = p.wiki(stem .. "ivano") 
	 prem1s = p.wiki(stem .. "ii");  prem2s = p.wiki(stem .. "isti");  prem3s = p.wiki(stem .. "ì")
	 prem1p = p.wiki(stem .. "immo");  prem2p = p.wiki(stem .. "iste");  prem3p = p.wiki(stem .. "irono") 
	 fut1s = p.wiki(stem .. "irò");  fut2s = p.wiki(stem .. "irai");  fut3s = p.wiki(stem .. "irà")
	 fut1p = p.wiki(stem .. "iremo");  fut2p = p.wiki(stem .. "irete");  fut3p = p.wiki(stem .. "iranno") 
	 cond1s = p.wiki(stem .. "irei");  cond2s = p.wiki(stem .. "iresti");  cond3s = p.wiki(stem .. "irebbe")
	 cond1p = p.wiki(stem .. "iremmo");  cond2p = p.wiki(stem .. "ireste");  cond3p = p.wiki(stem .. "irebbero") 
	 cong123s = p.wiki(stem .. "a"); cong3s = nil
	 cong1p = p.wiki(stem .. "iamo");  cong2p = p.wiki(stem .. "iate");  cong3p = p.wiki(stem .. "ano")
	 congimp12s = p.wiki(stem .. "issi");  congimp3s = p.wiki(stem .. "isse")
	 congimp1p = p.wiki(stem .. "issimo");  congimp2p = p.wiki(stem .. "iste");  congimp3p = p.wiki(stem .. "issero")
	 imp2s = p.wiki(stem .. "i");  imp3s = p.wiki(stem .. "a")
	 imp1p = p.wiki(stem .. "iamo");  imp2p = p.wiki(stem .. "ite");  imp3p = p.wiki(stem .. "ano")  
     elseif (type == "iare") or (type == "iarsi") then
	 inf = p.wiki(stem .. "are")
	 ger = p.wiki(stem .. "ando");  par = p.wiki(stem .. "ante");  pp = p.wiki(stem .. "ato")
	 pres1s = p.wiki(stem .. "o");  pres2s = p.wiki(stem);  pres3s = p.wiki(stem .. "a")
	 pres1p = p.wiki(stem .. "amo");  pres2p = p.wiki(stem .. "ate");  pres3p = p.wiki(stem .. "ano")        
	 imperf1s = p.wiki(stem .. "avo");  imperf2s = p.wiki(stem .. "avi");  imperf3s = p.wiki(stem .. "ava")
	 imperf1p = p.wiki(stem .. "avamo");  imperf2p = p.wiki(stem .. "avate");  imperf3p = p.wiki(stem .. "avano") 
	 prem1s = p.wiki(stem .. "ai");  prem2s = p.wiki(stem .. "asti");  prem3s = p.wiki(stem .. "ò")
	 prem1p = p.wiki(stem .. "ammo");  prem2p = p.wiki(stem .. "aste");  prem3p = p.wiki(stem .. "arono") 
	 fut1s = p.wiki(stem .. "erò");  fut2s = p.wiki(stem .. "erai");  fut3s = p.wiki(stem .. "erà")
	 fut1p = p.wiki(stem .. "eremo");  fut2p = p.wiki(stem .. "erete");  fut3p = p.wiki(stem .. "eranno") 
	 cond1s = p.wiki(stem .. "erei");  cond2s = p.wiki(stem .. "eresti");  cond3s = p.wiki(stem .. "erebbe")
	 cond1p = p.wiki(stem .. "eremmo");  cond2p = p.wiki(stem .. "ereste");  cond3p = p.wiki(stem .. "erebbero") 
	 cong123s = p.wiki(stem); cong3s = nil
	 cong1p = p.wiki(stem .. "amo");  cong2p = p.wiki(stem .. "ate");  cong3p = p.wiki(stem .. "no")
	 congimp12s = p.wiki(stem .. "assi");  congimp3s = p.wiki(stem .. "asse")
	 congimp1p = p.wiki(stem .. "assimo");  congimp2p = p.wiki(stem .. "aste");  congimp3p = p.wiki(stem .. "assero")
	 imp2s = p.wiki(stem .. "a");  imp3s = p.wiki(stem)
	 imp1p = p.wiki(stem .. "amo");  imp2p = p.wiki(stem .. "ate");  imp3p = p.wiki(stem .. "no")        
     elseif (type == "ciare") or (type == "ciarsi") or (type == "giare") or (type == "giarsi") then
	 inf = p.wiki(stem .. "iare")
	 ger = p.wiki(stem .. "iando");  par = p.wiki(stem .. "iante");  pp = p.wiki(stem .. "iato")
	 pres1s = p.wiki(stem .. "io");  pres2s = p.wiki(stem .. "i");  pres3s = p.wiki(stem .. "ia")
	 pres1p = p.wiki(stem .. "iamo");  pres2p = p.wiki(stem .. "iate");  pres3p = p.wiki(stem .. "iano")
	 imperf1s = p.wiki(stem .. "iavo");  imperf2s = p.wiki(stem .. "iavi");  imperf3s = p.wiki(stem .. "iava")
	 imperf1p = p.wiki(stem .. "iavamo");  imperf2p = p.wiki(stem .. "iavate");  imperf3p = p.wiki(stem .. "iavano")
	 prem1s = p.wiki(stem .. "iai");  prem2s = p.wiki(stem .. "iasti");  prem3s = p.wiki(stem .. "iò")
	 prem1p = p.wiki(stem .. "iammo");  prem2p = p.wiki(stem .. "iaste");  prem3p = p.wiki(stem .. "iarono") 
	 fut1s = p.wiki(stem .. "erò");  fut2s = p.wiki(stem .. "erai");  fut3s = p.wiki(stem .. "erà")
	 fut1p = p.wiki(stem .. "eremo");  fut2p = p.wiki(stem .. "erete");  fut3p = p.wiki(stem .. "eranno") 
	 cond1s = p.wiki(stem .. "erei");  cond2s = p.wiki(stem .. "eresti");  cond3s = p.wiki(stem .. "erebbe")
	 cond1p = p.wiki(stem .. "eremmo");  cond2p = p.wiki(stem .. "ereste");  cond3p = p.wiki(stem .. "erebbero") 
	 cong123s = p.wiki(stem .. "i"); cong3s = nil
	 cong1p = p.wiki(stem .. "iamo");  cong2p = p.wiki(stem .. "iate");  cong3p = p.wiki(stem .. "ino")
	 congimp12s = p.wiki(stem .. "iassi");  congimp3s = p.wiki(stem .. "iasse")
	 congimp1p = p.wiki(stem .. "iassimo");  congimp2p = p.wiki(stem .. "iaste");  congimp3p = p.wiki(stem .. "iassero")
	 imp2s = p.wiki(stem .. "ia");  imp3s = p.wiki(stem .. "i")
	 imp1p = p.wiki(stem .. "iamo");  imp2p = p.wiki(stem .. "iate");  imp3p = p.wiki(stem .. "ino")
     elseif type == "fare" then
	 inf = p.wiki(stem .. "fare")
	 ger = p.wiki(stem .. "facendo");  par = p.wiki(stem .. "facente");  pp = p.wiki(stem .. "fatto")
	 pres1s = p.wiki(stem .. "faccio");  pres2s = p.wiki(stem .. "fai");  pres3s = p.wiki(stem .. "fà")
	 pres1s2 = p.wiki(stem .. "fò")
	 pres1p = p.wiki(stem .. "facciamo");  pres2p = p.wiki(stem .. "fate");  pres3p = p.wiki(stem .. "fanno")        
	 imperf1s = p.wiki(stem .. "facevo");  imperf2s = p.wiki(stem .. "facevi");  imperf3s = p.wiki(stem .. "faceva")
	 imperf1p = p.wiki(stem .. "facevamo");  imperf2p = p.wiki(stem .. "facevate");  imperf3p = p.wiki(stem .. "facevano") 
	 prem1s = p.wiki(stem .. "feci");  prem2s = p.wiki(stem .. "facesti");  prem3s = p.wiki(stem .. "fece")
	 prem1p = p.wiki(stem .. "facemmo");  prem2p = p.wiki(stem .. "faceste");  prem3p = p.wiki(stem .. "fecero") 
	 fut1s = p.wiki(stem .. "farò");  fut2s = p.wiki(stem .. "farai");  fut3s = p.wiki(stem .. "farà")
	 fut1p = p.wiki(stem .. "faremo");  fut2p = p.wiki(stem .. "farete");  fut3p = p.wiki(stem .. "faranno") 
	 cond1s = p.wiki(stem .. "farei");  cond2s = p.wiki(stem .. "faresti");  cond3s = p.wiki(stem .. "farebbe")
	 cond1p = p.wiki(stem .. "faremmo");  cond2p = p.wiki(stem .. "fareste");  cond3p = p.wiki(stem .. "farebbero") 
	 cong123s = p.wiki(stem .. "faccia"); cong3s = nil
	 cong1p = p.wiki(stem .. "facciamo");  cong2p = p.wiki(stem .. "facciate");  cong3p = p.wiki(stem .. "facciano")
	 congimp12s = p.wiki(stem .. "facessi");  congimp3s = p.wiki(stem .. "facesse")
	 congimp1p = p.wiki(stem .. "facessimo");  congimp2p = p.wiki(stem .. "faceste");  congimp3p = p.wiki(stem .. "facessero")
	 imp2s = p.wiki(stem .. "fa");  imp3s = p.wiki(stem .. "faccia")
	 imp2s2 = p.wiki(stem .. "fai"); imp2s3 = p.wiki(stem .. "fa'")
	 imp1p = p.wiki(stem .. "facciamo");  imp2p = p.wiki(stem .. "faceste");  imp3p = p.wiki(stem .. "facessero")
     elseif (type == "urre") or (type == "ursi") then
	 inf = p.wiki(stem .. "urre")
	 ger = p.wiki(stem .. "ucendo");  par = p.wiki(stem .. "ucente");  pp = p.wiki(stem .. "otto")
	 pres1s = p.wiki(stem .. "uco");  pres2s = p.wiki(stem .. "uci");  pres3s = p.wiki(stem .. "uce")
	 pres1p = p.wiki(stem .. "uciamo");  pres2p = p.wiki(stem .. "ucete");  pres3p = p.wiki(stem .. "ucono")        
	 imperf1s = p.wiki(stem .. "ucevo");  imperf2s = p.wiki(stem .. "ucevi");  imperf3s = p.wiki(stem .. "uceva")
	 imperf1p = p.wiki(stem .. "ucevamo");  imperf2p = p.wiki(stem .. "ucevate");  imperf3p = p.wiki(stem .. "ucevano") 
	 prem1s = p.wiki(stem .. "ussi");  prem2s = p.wiki(stem .. "ucesti");  prem3s = p.wiki(stem .. "usse")
	 prem1p = p.wiki(stem .. "ucemmo");  prem2p = p.wiki(stem .. "uceste");  prem3p = p.wiki(stem .. "ussero")
	 fut1s = p.wiki(stem .. "urrò");  fut2s = p.wiki(stem .. "urrai");  fut3s = p.wiki(stem .. "urrà")
	 fut1p = p.wiki(stem .. "urremo");  fut2p = p.wiki(stem .. "urrete");  fut3p = p.wiki(stem .. "urranno") 
	 cond1s = p.wiki(stem .. "urrei");  cond2s = p.wiki(stem .. "urresti");  cond3s = p.wiki(stem .. "urrebbe")
	 cond1p = p.wiki(stem .. "urremmo");  cond2p = p.wiki(stem .. "urreste");  cond3p = p.wiki(stem .. "urrebbero") 
	 cong123s = p.wiki(stem .. "uca"); cong3s = nil
	 cong1p = p.wiki(stem .. "uciamo");  cong2p = p.wiki(stem .. "uciate");  cong3p = p.wiki(stem .. "ucano")
	 congimp12s = p.wiki(stem .. "ucessi");  congimp3s = p.wiki(stem .. "ucesse")
	 congimp1p = p.wiki(stem .. "ucessimo");  congimp2p = p.wiki(stem .. "uceste");  congimp3p = p.wiki(stem .. "ucessero")
	 imp2s = p.wiki(stem .. "uci");  imp3s = p.wiki(stem .. "uca")
	 imp1p = p.wiki(stem .. "uciamo");  imp2p = p.wiki(stem .. "ucete");  imp3p = p.wiki(stem .. "ucano")
 else error("Verb type " .. type .. "not supported.")
     end
 -- Test for reflexive verb and adjust accordingly.
     if type == "arsi" then
	 refl = true;
	 inf = p.wiki(stem .. "arsi")
	 ger = p.wiki(stem .. "andosi");
	 par = p.wiki(stem .. "antesi");
	 pp2 = p.wiki(stem .. "atosi")
	 imp2s = p.wiki(stem .. "ati");
	 imp1p = p.wiki(stem .. "iamoci");
	 imp2p = p.wiki(stem .. "atevi")
     elseif type == "carsi" then
	 refl = true; inf = p.wiki(stem .. "arsi")
	 ger = p.wiki(stem .. "andosi"); par = p.wiki(stem .. "antesi"); pp2 = p.wiki(stem .. "atosi")
	 imp2s = p.wiki(stem .. "ati"); imp1p = p.wiki(stem .. "hiamoci"); imp2p = p.wiki(stem .. "atevi")
     elseif type == "ciarsi" then
	 refl = true; inf = p.wiki(stem .. "iarsi")
	 ger = p.wiki(stem .. "iandosi"); par = p.wiki(stem .. "iantesi"); pp2 = p.wiki(stem .. "iatosi")
	 imp2s = p.wiki(stem .. "iati"); imp1p = p.wiki(stem .. "iamoci"); imp2p = p.wiki(stem .. "iatevi")
     elseif type == "ersi" then
	 refl = true; inf = p.wiki(stem .. "ersi")
	 ger = p.wiki(stem .. "endosi"); par = p.wiki(stem .. "entesi"); pp2 = p.wiki(stem .. "utosi")
	 imp2s = p.wiki(stem .. "iti"); imp1p = p.wiki(stem .. "iamoci"); imp2p = p.wiki(stem .. "etevi")
     elseif type == "iarsi" then
	 refl = true; inf = p.wiki(stem .. "arsi")
	 ger = p.wiki(stem .. "andosi"); par = p.wiki(stem .. "antesi"); pp2 = p.wiki(stem .. "atosi")
	 imp2s = p.wiki(stem .. "ati"); imp1p = p.wiki(stem .. "amoci"); imp2p = p.wiki(stem .. "atevi")
     elseif type == "irsi" then
	 refl = true; inf = p.wiki(stem .. "irsi")
	 ger = p.wiki(stem .. "endosi"); par = p.wiki(stem .. "entesi"); pp2 = p.wiki(stem .. "itosi")
	 imp2s = p.wiki(stem .. "iti"); imp1p = p.wiki(stem .. "iamoci"); imp2p = p.wiki(stem .. "itevi")
     elseif type == "irsi-b" then
	 refl = true; inf = p.wiki(stem .. "irsi")
	 ger = p.wiki(stem .. "endosi"); par = p.wiki(stem .. "entesi"); pp2 = p.wiki(stem .. "itosi")
	 imp2s = p.wiki(stem .. "isciti"); imp1p = p.wiki(stem .. "iamoci"); imp2p = p.wiki(stem .. "itevi")
     elseif type == "ursi" then
	 refl = true; inf = p.wiki(stem .. "ursi")
	 ger = p.wiki(stem .. "ucendosi"); par = p.wiki(stem .. "ucentesi"); pp2 = p.wiki(stem .. "ottosi")
	 imp2s = p.wiki(stem .. "uciti"); imp1p = p.wiki(stem .. "uciamoci"); imp2p = p.wiki(stem .. "ucetevi")
     end
     if refl then mi = "mi "; ti = "ti "; si = "si "; ci = "ci "; vi = "vi " end
 -- Get all the overriden forms and any alternative forms.
 -- Participles
     inf = p.over(inf,args["inf"])
     ger = p.ovaer(ger,args["ger"])
     ger2 = p.wiki(args["ger2"])
     ger = p.alts(ger, ger2)
     par = p.over(par,args["par"])
     par2 = p.wiki(args["par2"])
     par = p.alts(par, par2)
     pp = p.over(pp,args["pp"])
     pp2 = p.wiki(args["pp2"]);  pp3 = p.wiki(args["pp3"]);  pp3 = p.wiki(args["pp3"]);  pp4 = p.wiki(args["pp4"])
     pp = p.alts(pp, pp2); pp = p.alts(pp, pp3); pp = p.alts(pp, pp4)
 -- Present
     pres1s = p.over(pres1s,args["pres1s"]); pres2s = p.over(pres2s,args["pres2s"]); pres3s = p.over(pres3s,args["pres3s"])
     pres1p = p.over(pres1p,args["pres1p"]); pres2p = p.over(pres2p,args["pres2p"]); pres3p = p.over(pres3p,args["pres3p"])
     pres1s2 = p.over(pres1s2, args["pres1s2"]);  pres2s2 = p.wiki(args["pres2s2"]);  pres3s2 = p.wiki(args["pres3s2"])
     pres1p2 = p.wiki(args["pres1p2"]);  pres2p2 = p.wiki(args["pres2p2"]);  pres3p2 = p.wiki(args["pres3p2"])
     pres1s = p.alts(pres1s, pres1s2); pres2s = p.alts(pres2s, pres2s2); pres3s = p.alts(pres3s, pres3s2) 
     pres1p = p.alts(pres1p, pres1p2); pres2p = p.alts(pres2p, pres2p2); pres3p = p.alts(pres3p, pres3p2)     
 -- Imperfect
     imperf1s = p.over(imperf1s,args["imperf1s"]); imperf2s = p.over(imperf2s,args["imperf2s"]); imperf3s = p.over(imperf3s,args["imperf3s"])
     imperf1p = p.over(imperf1p,args["imperf1p"]); imperf2p = p.over(imperf2p,args["imperf2p"]); imperf3p = p.over(imperf3p,args["imperf3p"])
     imperf1s2 = p.wiki(args["imperf1s2"]);  imperf2s2 = p.wiki(args["imperf2s2"]);  imperf3s2 = p.wiki(args["imperf3s2"])
     imperf1p2 = p.wiki(args["imperf1p2"]);  imperf2p2 = p.wiki(args["imperf2p2"]);  imperf3p2 = p.wiki(args["imperf3p2"])
     imperf1s = p.alts(imperf1s, imperf1s2); imperf2s = p.alts(imperf2s, imperf2s2); imperf3s = p.alts(imperf3s, imperf3s2)
     imperf1p = p.alts(imperf1p, imperf1p2); imperf2p = p.alts(imperf2p, imperf2p2); imperf3p = p.alts(imperf3p, imperf3p2)
 -- Passato Remoto (Past historic)
     prem1s = p.over(prem1s,args["prem1s"]); prem2s = p.over(prem2s,args["prem2s"]); prem3s = p.over(prem3s,args["prem3s"])
     prem1p = p.over(prem1p,args["prem1p"]); prem2p = p.over(prem2p,args["prem2p"]); prem3p = p.over(prem3p,args["prem3p"])
     prem1s2 = p.wiki(args["prem1s2"]);  prem2s2 = p.wiki(args["prem2s2"]);  prem3s2 = p.over(prem3s2,args["prem3s2"])
     prem1p2 = p.wiki(args["prem1p2"]);  prem2p2 = p.wiki(args["prem2p2"]);  prem3p2 = p.over(prem3p2,args["prem3p2"])
     prem1s = p.alts(prem1s, prem1s2); prem2s = p.alts(prem2s, prem2s2); prem3s = p.alts(prem3s, prem3s2)
     prem1p = p.alts(prem1p, prem1p2); prem2p = p.alts(prem2p, prem2p2); prem3p = p.alts(prem3p, prem3p2)
 -- Some extra alternatives for this
     prem1s3 = p.wiki(args["prem1s3"]); prem1s = p.alts(prem1s, prem1s3)
     prem3s3 = p.wiki(args["prem3s3"]); prem3s = p.alts(prem3s, prem3s3)
     prem3p3 = p.wiki(args["prem3p3"]); prem3p = p.alts(prem3p, prem3p3)
 -- Future
     fut1s = p.over(fut1s,args["fut1s"]); fut2s = p.over(fut2s,args["fut2s"]); fut3s = p.over(fut3s,args["fut3s"])
     fut1p = p.over(fut1p,args["fut1p"]); fut2p = p.over(fut2p,args["fut2p"]); fut3p = p.over(fut3p,args["fut3p"])
     fut1s2 = p.wiki(args["fut1s2"]);  fut2s2 = p.wiki(args["fut2s2"]);  fut3s2 = p.wiki(args["fut3s2"])
     fut1p2 = p.wiki(args["fut1p2"]);  fut2p2 = p.wiki(args["fut2p2"]);  fut3p2 = p.wiki(args["fut3p2"])
     fut1s = p.alts(fut1s, fut1s2); fut2s = p.alts(fut2s, fut2s2); fut3s = p.alts(fut3s, fut3s2)
     fut1p = p.alts(fut1p, fut1p2); fut2p = p.alts(fut2p, fut2p2); fut3p = p.alts(fut3p, fut3p2)
 -- Conditional
     cond1s = p.over(cond1s,args["cond1s"]); cond2s = p.over(cond2s,args["cond2s"]); cond3s = p.over(cond3s,args["cond3s"])
     cond1p = p.over(cond1p,args["cond1p"]); cond2p = p.over(cond2p,args["cond2p"]); cond3p = p.over(cond3p,args["cond3p"])
     cond1s2 = p.wiki(args["cond1s2"]);  cond2s2 = p.wiki(args["cond2s2"]);  cond3s2 = p.wiki(args["cond3s2"])
     cond1p2 = p.wiki(args["cond1p2"]);  cond2p2 = p.wiki(args["cond2p2"]);  cond3p2 = p.wiki(args["cond3p2"])
     cond1s = p.alts(cond1s, cond1s2); cond2s = p.alts(cond2s, cond2s2); cond3s = p.alts(cond3s, cond3s2)
     cond1p = p.alts(cond1p, cond1p2); cond2p = p.alts(cond2p, cond2p2); cond3p = p.alts(cond3p, cond3p2)
 -- Present congjunctive
     cong123s = p.over(cong123s,args["cong123s"]);  cong3s = p.over(cong3s,args["cong3s"])
     cong1p = p.over(cong1p,args["cong1p"]); cong2p = p.over(cong2p,args["cong2p"]); cong3p = p.over(cong3p,args["cong3p"])
     cong123s2 = p.wiki(args["cong123s2"]);  cong3s2 = p.wiki(args["cong3s2"])
     cong1p2 = p.wiki(args["cong1p2"]);  cong2p2 = p.wiki(args["cong2p2"]);  cong3p2 = p.wiki(args["cong3p2"])
     cong123s = p.alts(cong123s, cong123s2); cong3s = p.alts(cong3s, cong3s2)
     if cong3s == nil then cong3s = cong123s end
     cong1p = p.alts(cong1p, cong1p2); cong2p = p.alts(cong2p, cong2p2); cong3p = p.alts(cong3p, cong3p2)
 -- Imperfect congjunctive
     congimp12s = p.over(congimp12s,args["congimp12s"]); congimp3s = p.over(congimp3s,args["congimp3s"])
     congimp1p = p.over(congimp1p,args["congimp1p"]); congimp2p = p.over(congimp2p,args["congimp2p"]); congimp3p = p.over(congimp3p,args["congimp3p"])
     congimp12s2 = p.wiki(args["congimp12s2"]);  congimp3s2 = p.wiki(args["congimp3s2"])
     congimp1p2 = p.wiki(args["congimp1p2"]);  congimp2p2 = p.wiki(args["congimp2p2"]);  congimp3p2 = p.wiki(args["congimp3p2"])
     congimp1s = p.alts(congimp12s, congimp12s2); congimp3s = p.alts(congimp3s, congimp3s2)
     congimp1p = p.alts(congimp1p, congimp1p2); congimp2p = p.alts(congimp2p, congimp2p2); congimp3p = p.alts(congimp3p, congimp3p2)    
 -- Imperative
     imp2s = p.over(imp2s,args["imp2s"]); imp3s = p.over(imp3s,args["imp3s"])
     imp1p = p.over(imp1p,args["imp1p"]); imp2p = p.over(imp2p,args["imp2p"]); imp3p = p.over(imp3p,args["imp3p"])
     imp2s2 = p.over(imp2s2, args["imp2s2"]);  imp3s2 = p.wiki(args["imp3s2"])
     imp1p2 = p.wiki(args["imp1p2"]);  imp2p2 = p.wiki(args["imp2p2"]);  imp3p2 = p.wiki(args["imp3p2"])
     imp2s = p.alts(imp2s, imp2s2); imp3s = p.alts(imp3s, imp3s2)
     imp1p = p.alts(imp1p, imp1p2); imp2p = p.alts(imp2p, imp2p2); imp3p = p.alts(imp3p, imp3p2)
 -- An extra alternative
      imp2s3 = p.over(imp2s3, args["imp2s3"]); imp2s = p.alts(imp2s, imp2s3)
 -- Reflexive pronouns
     mi = p.over(mi,args["mi"],0); ti = p.over(ti,args["ti"],0); si = p.over(si,args["si"],0); ci = p.over(ci,args["ci"],0); vi = p.over(vi,args["vi"],0)  
 -- Build pretty table
     conj = '{| style="background:#F0F0F0;border-collapse:separate;border-spacing:2px" class="inflection-table"\n'
     conj = conj .. '|-\n'
     conj = conj .. '! colspan="1" style="background:#e2e4c0" | infinito\n'
     conj = conj .. '| colspan="1" | ' .. inf .. '\n'
     conj = conj .. '|-\n'
     conj = conj .. '! colspan="2" style="background:#e2e4c0" | verbo ausiliare\n'
     conj = conj .. '| colspan="1" | ' .. aus ..'\n'
     conj = conj .. '! colspan="2" style="background:#e2e4c0" | gerundio\n'
     conj = conj .. '| colspan="2" | ' .. ger .. '\n'
     conj = conj .. '|-\n! colspan="2" style="background:#e2e4c0" | participio presente\n'
     conj = conj .. '| colspan="1" | ' .. par .. '\n'
     conj = conj .. '! colspan="2" style="background:#e2e4c0" | participio passato\n'
     conj = conj .. '| colspan="2" | ' .. pp .. '\n'
     conj = conj .. '|-\n! colspan="1" rowspan="2" style="background:#C0C0C0" | persona\n'
     conj = conj .. '! colspan="3" style="background:#C0C0C0" | singolare\n'
     conj = conj .. '! colspan="3" style="background:#C0C0C0" | plurale\n'
     conj = conj .. '|-\n! style="background:#C0C0C0;width:12.5%" | prima\n'
     conj = conj .. '! style="background:#C0C0C0;width:12.5%" | seconda\n'
     conj = conj .. '! style="background:#C0C0C0;width:12.5%" | terza\n'
     conj = conj .. '! style="background:#C0C0C0;width:12.5%" | prima\n'
     conj = conj .. '! style="background:#C0C0C0;width:12.5%" | seconda\n'
     conj = conj .. '! style="background:#C0C0C0;width:12.5%" | terza\n'
     conj = conj .. '|-\n! style="background:#c0cfe4" colspan="1" | indicativo\n'
     conj = conj .. '! style="background:#c0cfe4" | io\n'
     conj = conj .. '! style="background:#c0cfe4" | tu\n'
     conj = conj .. '! style="background:#c0cfe4" | lui/lei\n'
     conj = conj .. '! style="background:#c0cfe4" | noi\n'
     conj = conj .. '! style="background:#c0cfe4" | voi\n'
     conj = conj .. '! style="background:#c0cfe4" | essi/esse\n|-\n'
     conj = conj .. '! style="height:3em;background:#c0cfe4" colspan="1" | presente\n'
     conj = conj .. '|' .. mi .. pres1s .. '\n|' .. ti .. pres2s .. '\n|' .. si .. pres3s .. '\n|' .. ci .. pres1p .. '\n|' .. vi .. pres2p .. '\n|' .. si .. pres3p .. '\n'
     conj = conj .. '|-\n! style="height:3em;background:#c0cfe4" colspan="1" | imperfetto\n'
     conj = conj .. '|' .. mi .. imperf1s .. '\n|' .. ti .. imperf2s .. '\n|' .. si .. imperf3s .. '\n|' .. ci .. imperf1p .. '\n|' .. vi .. imperf2p .. '\n|' .. si .. imperf3p .. '\n'    
     conj = conj .. '|-\n! style="height:3em;background:#c0cfe4" colspan="1" | passato remoto\n'
     conj = conj .. '|' .. mi .. prem1s .. '\n|' .. ti .. prem2s .. '\n|' .. si .. prem3s .. '\n|' .. ci .. prem1p .. '\n|' .. vi .. prem2p .. '\n|' .. si .. prem3p .. '\n'
     conj = conj .. '|-\n! style="height:3em;background:#c0cfe4" colspan="1" | futuro\n'
     conj = conj .. '|' .. mi .. fut1s .. '\n|' .. ti .. fut2s .. '\n|' .. si .. fut3s .. '\n|' .. ci .. fut1p .. '\n|' .. vi .. fut2p .. '\n|' .. si .. fut3p .. '\n'
     conj = conj .. '|-\n! style="background:#c0d8e4" colspan="1" | condizionale\n'
     conj = conj .. '! style="background:#c0d8e4" | io\n'
     conj = conj .. '! style="background:#c0d8e4" | tu\n'
     conj = conj .. '! style="background:#c0d8e4" | lui/lei\n'
     conj = conj .. '! style="background:#c0d8e4" | noi\n'
     conj = conj .. '! style="background:#c0d8e4" | voi\n'
     conj = conj .. '! style="background:#c0d8e4" | essi/esse\n'
     conj = conj .. '|-\n! style="height:3em;background:#c0d8e4" colspan="1" | presente\n'
     conj = conj .. '|' .. mi .. cond1s .. '\n|' .. ti .. cond2s .. '\n|' .. si .. cond3s .. '\n|' .. ci .. cond1p .. '\n|' .. vi .. cond2p .. '\n|' .. si .. cond3p .. '\n'   
     conj = conj .. '|-\n! style="background:#c0e4c0" colspan="1" | congiuntivo\n'
     conj = conj .. '! style="background:#c0e4c0" | che io\n'
     conj = conj .. '! style="background:#c0e4c0" | che tu\n'
     conj = conj .. '! style="background:#c0e4c0" | che lui/che lei\n'
     conj = conj .. '! style="background:#c0e4c0" | che noi\n'
     conj = conj .. '! style="background:#c0e4c0" | che voi\n'
     conj = conj .. '! style="background:#c0e4c0" | che essi/che esse\n|-\n'
     conj = conj .. '! style="height:3em;background:#c0e4c0" | presente\n'
     conj = conj .. '|' .. mi .. cong123s .. '\n|' .. ti .. cong123s .. '\n|' .. si .. cong3s .. '\n|' .. ci .. cong1p .. '\n|' .. vi .. cong2p .. '\n|' .. si .. cong3p .. '\n'   
     conj = conj .. '|-\n! style="height:3em;background:#c0e4c0" rowspan="1" | imperfetto\n'
     conj = conj .. '|' .. mi .. congimp12s .. '\n|' .. ti .. congimp12s .. '\n|' .. si .. congimp3s .. '\n|' .. ci .. congimp1p .. '\n|' .. vi .. congimp2p .. '\n|' .. si .. congimp3p .. '\n' 
     conj = conj .. '|-\n! colspan="1" rowspan="2" style="height:3em;background:#e4d4c0" | imperativo\n'
     conj = conj .. '! style="background:#e4d4c0" | -\n'
     conj = conj .. '! style="background:#e4d4c0" | tu\n'
     conj = conj .. '! style="background:#e4d4c0" | lui/lei\n'
     conj = conj .. '! style="background:#e4d4c0" | noi\n'
     conj = conj .. '! style="background:#e4d4c0" | voi\n'
     conj = conj .. '! style="background:#e4d4c0" | essi/esse\n'
     conj = conj .. '|-\n|\n'
     conj = conj .. '|' .. imp2s .. '\n|' .. si .. imp3s .. '\n|' .. imp1p .. '\n|' .. imp2p .. '\n|' .. si .. imp3p .. '\n'
     conj = conj .. '|-\n'    
     conj = conj .. '|}'
     return conj 
 end

 function p.over(x,over,xtra)
 -- For use within p.itconj function.
 -- Replaces a term with one overriden in the template invocation.
     if over == nil then return x end
     if over < "a" then return '' end
     if xtra == 0 then return over .. " " end -- for reflexive pronouns
     return "[[" .. over .. "#Italiano|" .. over .. "]]"
 end

 function p.wiki(x)
 -- For use within p.itconj function.
 -- Wikifies term, converting nils to single spaces (for ease of concatenation).
     if x == nil then return " " end
     if x == "" then return " " end
     return "[[" .. x .. "#Italiano|" .. x .. "]]"
 end

 function p.alts(x,y)
 -- For use within p.itconj function.
 -- Adds alternate forms with a comma in between.
 --    if y == nil then return x end
     if y >= "a" then return x .. ", " .. y end
     return x
 end

 return p
