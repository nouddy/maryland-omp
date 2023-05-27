//! Task actor preload
task resetActorPos[4000]() {

    //! Biro aktori
    SetActorPos(ActorMidBiro, 1462.9066,-989.0536,26.8850);
    SetActorFacingAngle(ActorMidBiro, 182.1244);
    ApplyActorAnimation( ActorMidBiro, "GANGS", "prtial_gngtlkA", 4.0, 1, 1, 1, 1, 0 );

    SetActorPos(ActorLeftBiro, 1468.0260,-987.2319,26.8850);
    SetActorFacingAngle(ActorLeftBiro, 175.0012);
    ApplyActorAnimation( ActorLeftBiro, "GANGS", "prtial_gngtlkA", 4.0, 1, 1, 1, 1, 0 );

    SetActorPos(ActorRightBiro, 1456.9764,-987.2343,26.8850);
    SetActorFacingAngle(ActorRightBiro, 187.8715);
    ApplyActorAnimation( ActorRightBiro, "GANGS", "prtial_gngtlkA", 4.0, 1, 1, 1, 1, 0 );

    //! Servis aktori
    SetActorPos(mehanicar1, 1104.9012,-1226.2242,15.8346);
    SetActorFacingAngle(mehanicar1, 275.4460);

    SetActorPos(mehanicar2, 1098.3132,-1226.4584,15.8346);
    SetActorFacingAngle(mehanicar2, 94.1730);

    //! Spawn Aktor
    SetActorPos(SpawnAktor, 973.7034,-1097.2644,23.8788);
    SetActorFacingAngle(SpawnAktor, 356.0803);
    ApplyActorAnimation(SpawnAktor, "GANGS", "leanOUT", 4.1, 1, 0, 0, 0, 0);

    //! Bank Aktori
    SetActorPos(AktorPrizemlje, 1792.7607,-1302.4524,13.5277);
    SetActorFacingAngle(AktorPrizemlje, 0.1496);
    ApplyActorAnimation(AktorPrizemlje, "DEALER", "DEALER_IDLE", 4.1, 1, 0, 0, 0, 0);

    SetActorPos(ActorOpenRacuna, 1831.5023,-1272.4097,22.2109);
    SetActorFacingAngle(ActorOpenRacuna, 139.4119);
    ApplyActorAnimation(ActorOpenRacuna, "GANGS", "prtial_gngtlkA", 4.1, 1, 0, 0, 0, 0);

    SetActorPos(AktorHipoteka, 1816.2584,-1274.6991,22.2109);
    SetActorFacingAngle(AktorHipoteka, 216.5893);
    ApplyActorAnimation(AktorHipoteka, "GANGS", "prtial_gngtlkA", 4.1, 1, 0, 0, 0, 0);

    return 1;
}
