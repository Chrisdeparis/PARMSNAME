**free                                                                                              
ctl-opt option(*srcstmt) dftactgrp(*No);                                                            
                                                                                                    
// ds spécifique au prog callNomCli                                                                 
/copy MILFORT/qcopsrc,cnomclids                                                                     
                                                                                                    
// ds commune au prog callNOMCLI et au progr nomCli                                                 
/copy MILFORT/qcopsrc,nomCliDs                                                                      
                                                                                                    
dcl-pi *n;                                                                                          
  // paremeter list = un seul élément une ds = un seul parm = num cli                               
  cnomclids likeDs(cnomclids_template);                                                             
end-pi;                                                                                             
                                                                                                    
dcl-pr nomcli extpgm('NOMCLI');                                                                     
  toto likeDs(nomCliDs_template);                                                                   
end-pr;                                                                                             
                                                                                                    
dcl-ds nomCliDs  likeDs(nomCliDs_template);                                                         
                                                                                                    
// variables de travail                                                                             
dcl-s w_message char(50);                                                                           
dcl-s w_numCliChar int(10);                                                                         
dcl-s w_nomCliChar char(50);                                                                        
dcl-s w_returnCodeNum int(10);                                                                      
                                                                                                    
dcl-s errCheckParm ind;                                                                             
                                                                                                    
//dcl-s nomClient char(50) inz('DUPONT');                                                           
//dcl-s numClient char(5) inz('1');                                                                 
                                                                                                    
monitor;                                                                                            
                                                                                                    
//  clear w_message;                                                                                
//  clear parmDs;                                                                                   
                                                                                                    
  //exsr checkParm;                                                                                 
  //if not errCheckParm;                                                                            
                                                                                                    
//  parmDs.inDs.numClient = w_numCliChar;                                                           
//  parmDs.ouDs.nomClient = w_nomCliChar;                                                           
//  parmDS.ouDS.returncode = w_returnCodeNum;                                                       
                                                                                                    
  w_message =   'cnomclids :  ( num client : '                                                      
              + %trim(cnomcliDS.numCliChar)                                                         
              + ')';                                                                                
                                                                                                    
  dsply (%trim(w_message));                                                                         
                                                                                                    
  nomCliDS.inDs.numClient = cnomcliDS.numCliChar;                                                   
                                                                                                    
  nomCli (nomCliDs);                                                                                
                                                                                                    
  clear w_message;                                                                                  
  w_message =   ' in.n°Client '                                                                     
              + %trim(nomCliDS.inDS.numClient)                                                      
              + ' ou.nom '                                                                          
              + %trim(nomCliDs.ouDS.nomClient)                                                      
              + ' ou.rc '                                                                           
              + %char(nomCliDs.ouDS.returnCode)                                                     
              + ')';                                                                                
                                                                                                    
  dsply (%trim(w_message));                                                                         
                                                                                                    
  //else;                                                                                           
// erreur parametres                                                                                
//endif;                                                                                            
                                                                                                    
on-error *all;                                                                                      
                                                                                                    
endmon;                                                                                             
//endif;                                                                                            
                                                                                                    
*inlr = *on;                                                                                        
                                                                                                    
//---------------------------------------------------------------------                             
                                                                                                    
//  begsr checkParm;                                                                                
//                                                                                                  
//errCheckParm = *off;                                                                              
//                                                                                                  
//// controle valeur de numClient                                                                   
//if parmDs.numClient <> *blanks;                                                                   
//  monitor;                                                                                        
//    w_numCliChar = 0;                                                                             
//    w_numCliChar = %dec(parmDs.numClient:5:0);                                                    
//    // controle valeur de nomClient                                                               
//    if parmDs.nomClient <> *blanks;                                                               
//      monitor;                                                                                    
//        w_nomCliChar = 0;                                                                         
//        w_nomCliChar = %dec(parmDs3.nomClient:50:0);                                              
//      on-error *all; // nomClient non numérique                                                   
//        errCheckParm = *on;                                                                       
//      endmon;                                                                                     
//    else; // nomClient = blanc                                                                    
//      errCheckParm = *on;                                                                         
//    endif;                                                                                        
//  on-error *all; // numClient non numérique                                                       
//    errCheckParm = *on;                                                                           
//  endmon;                                                                                         
//else; // numClient = blanc                                                                        
//  errCheckParm = *on;                                                                             
//endif;                                                                                            
                                                                                                    
//if errCheckParm;                                                                                  
//  dsply ('le parametre numClient ou le parametre nomClient est invalide');                        
//endif;                                                                                            
                                                                                                    
//endsr;                                                                                             
