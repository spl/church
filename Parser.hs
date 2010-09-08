-- parser produced by Happy Version 1.13

module Parser where
import Error
import Lexer
import Datastructure
import ParseMonad

data HappyAbsSyn 
	= HappyTerminal Token
	| HappyErrorToken Int
	| HappyAbsSyn4 ([PDef])
	| HappyAbsSyn5 (PDef)
	| HappyAbsSyn6 (PExp)
	| HappyAbsSyn7 ([PExp])
	| HappyAbsSyn9 (Maybe PExp)

type HappyReduction = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> P(HappyAbsSyn))
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> P(HappyAbsSyn))] 
	-> HappyStk HappyAbsSyn 
	-> P(HappyAbsSyn)

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74 :: Int -> HappyReduction

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33 :: HappyReduction

action_0 (29) = happyShift action_4
action_0 (30) = happyShift action_5
action_0 (4) = happyGoto action_2
action_0 (5) = happyGoto action_3
action_0 _ = happyReduce_1

action_1 _ = happyFail

action_2 (32) = happyAccept
action_2 _ = happyFail

action_3 (29) = happyShift action_4
action_3 (30) = happyShift action_5
action_3 (4) = happyGoto action_8
action_3 (5) = happyGoto action_3
action_3 _ = happyReduce_1

action_4 (21) = happyShift action_7
action_4 _ = happyFail

action_5 (21) = happyShift action_6
action_5 _ = happyFail

action_6 (20) = happyShift action_10
action_6 _ = happyFail

action_7 (20) = happyShift action_9
action_7 _ = happyFail

action_8 _ = happyReduce_2

action_9 (16) = happyShift action_21
action_9 (22) = happyShift action_22
action_9 (23) = happyShift action_23
action_9 (14) = happyGoto action_19
action_9 (15) = happyGoto action_20
action_9 _ = happyFail

action_10 (18) = happyShift action_14
action_10 (21) = happyShift action_15
action_10 (22) = happyShift action_16
action_10 (23) = happyShift action_17
action_10 (27) = happyShift action_18
action_10 (11) = happyGoto action_11
action_10 (12) = happyGoto action_12
action_10 (13) = happyGoto action_13
action_10 _ = happyFail

action_11 _ = happyReduce_25

action_12 (17) = happyShift action_36
action_12 (18) = happyShift action_14
action_12 (21) = happyShift action_15
action_12 (22) = happyShift action_16
action_12 (23) = happyShift action_17
action_12 (27) = happyShift action_18
action_12 (11) = happyGoto action_35
action_12 _ = happyReduce_27

action_13 (28) = happyShift action_33
action_13 (31) = happyShift action_34
action_13 _ = happyFail

action_14 (21) = happyShift action_32
action_14 _ = happyFail

action_15 _ = happyReduce_20

action_16 (18) = happyShift action_14
action_16 (21) = happyShift action_15
action_16 (22) = happyShift action_16
action_16 (23) = happyShift action_17
action_16 (27) = happyShift action_18
action_16 (11) = happyGoto action_11
action_16 (12) = happyGoto action_12
action_16 (13) = happyGoto action_31
action_16 _ = happyFail

action_17 (18) = happyShift action_14
action_17 (21) = happyShift action_15
action_17 (22) = happyShift action_16
action_17 (23) = happyShift action_17
action_17 (27) = happyShift action_18
action_17 (11) = happyGoto action_11
action_17 (12) = happyGoto action_12
action_17 (13) = happyGoto action_30
action_17 _ = happyFail

action_18 (21) = happyShift action_29
action_18 _ = happyFail

action_19 (17) = happyShift action_28
action_19 _ = happyReduce_32

action_20 (28) = happyShift action_26
action_20 (31) = happyShift action_27
action_20 _ = happyFail

action_21 _ = happyReduce_29

action_22 (16) = happyShift action_21
action_22 (22) = happyShift action_22
action_22 (23) = happyShift action_23
action_22 (14) = happyGoto action_19
action_22 (15) = happyGoto action_25
action_22 _ = happyFail

action_23 (16) = happyShift action_21
action_23 (22) = happyShift action_22
action_23 (23) = happyShift action_23
action_23 (14) = happyGoto action_19
action_23 (15) = happyGoto action_24
action_23 _ = happyFail

action_24 (24) = happyShift action_51
action_24 _ = happyFail

action_25 _ = happyReduce_31

action_26 _ = happyReduce_5

action_27 (18) = happyShift action_14
action_27 (21) = happyShift action_15
action_27 (22) = happyShift action_16
action_27 (23) = happyShift action_17
action_27 (27) = happyShift action_18
action_27 (11) = happyGoto action_11
action_27 (12) = happyGoto action_12
action_27 (13) = happyGoto action_50
action_27 _ = happyFail

action_28 (16) = happyShift action_21
action_28 (22) = happyShift action_22
action_28 (23) = happyShift action_23
action_28 (14) = happyGoto action_19
action_28 (15) = happyGoto action_49
action_28 _ = happyFail

action_29 (20) = happyShift action_48
action_29 _ = happyFail

action_30 (24) = happyShift action_47
action_30 _ = happyFail

action_31 _ = happyReduce_22

action_32 (20) = happyShift action_46
action_32 (10) = happyGoto action_45
action_32 _ = happyReduce_18

action_33 _ = happyReduce_6

action_34 (18) = happyShift action_40
action_34 (19) = happyShift action_41
action_34 (21) = happyShift action_42
action_34 (22) = happyShift action_43
action_34 (23) = happyShift action_44
action_34 (6) = happyGoto action_38
action_34 (8) = happyGoto action_39
action_34 _ = happyFail

action_35 _ = happyReduce_26

action_36 (18) = happyShift action_14
action_36 (21) = happyShift action_15
action_36 (22) = happyShift action_16
action_36 (23) = happyShift action_17
action_36 (27) = happyShift action_18
action_36 (11) = happyGoto action_11
action_36 (12) = happyGoto action_12
action_36 (13) = happyGoto action_37
action_36 _ = happyFail

action_37 _ = happyReduce_28

action_38 (28) = happyShift action_63
action_38 _ = happyFail

action_39 (18) = happyShift action_40
action_39 (19) = happyShift action_41
action_39 (21) = happyShift action_42
action_39 (22) = happyShift action_43
action_39 (23) = happyShift action_44
action_39 (25) = happyShift action_62
action_39 (7) = happyGoto action_60
action_39 (8) = happyGoto action_61
action_39 _ = happyReduce_8

action_40 (21) = happyShift action_59
action_40 _ = happyFail

action_41 (21) = happyShift action_58
action_41 _ = happyFail

action_42 _ = happyReduce_10

action_43 (18) = happyShift action_40
action_43 (19) = happyShift action_41
action_43 (21) = happyShift action_42
action_43 (22) = happyShift action_43
action_43 (23) = happyShift action_44
action_43 (6) = happyGoto action_57
action_43 (8) = happyGoto action_39
action_43 _ = happyFail

action_44 (18) = happyShift action_40
action_44 (19) = happyShift action_41
action_44 (21) = happyShift action_42
action_44 (22) = happyShift action_43
action_44 (23) = happyShift action_44
action_44 (6) = happyGoto action_56
action_44 (8) = happyGoto action_39
action_44 _ = happyFail

action_45 (18) = happyShift action_14
action_45 (21) = happyShift action_15
action_45 (22) = happyShift action_16
action_45 (23) = happyShift action_17
action_45 (27) = happyShift action_18
action_45 (11) = happyGoto action_55
action_45 _ = happyFail

action_46 (16) = happyShift action_21
action_46 (22) = happyShift action_22
action_46 (23) = happyShift action_23
action_46 (14) = happyGoto action_54
action_46 _ = happyFail

action_47 _ = happyReduce_21

action_48 (16) = happyShift action_21
action_48 (22) = happyShift action_22
action_48 (23) = happyShift action_23
action_48 (14) = happyGoto action_53
action_48 _ = happyFail

action_49 _ = happyReduce_33

action_50 (28) = happyShift action_52
action_50 _ = happyFail

action_51 _ = happyReduce_30

action_52 _ = happyReduce_3

action_53 (18) = happyShift action_14
action_53 (21) = happyShift action_15
action_53 (22) = happyShift action_16
action_53 (23) = happyShift action_17
action_53 (27) = happyShift action_18
action_53 (11) = happyGoto action_70
action_53 _ = happyFail

action_54 _ = happyReduce_19

action_55 _ = happyReduce_24

action_56 (24) = happyShift action_69
action_56 _ = happyFail

action_57 _ = happyReduce_12

action_58 (20) = happyShift action_46
action_58 (10) = happyGoto action_68
action_58 _ = happyReduce_18

action_59 (20) = happyShift action_67
action_59 (9) = happyGoto action_66
action_59 _ = happyReduce_16

action_60 _ = happyReduce_7

action_61 (18) = happyShift action_40
action_61 (19) = happyShift action_41
action_61 (21) = happyShift action_42
action_61 (22) = happyShift action_43
action_61 (23) = happyShift action_44
action_61 (25) = happyShift action_62
action_61 (7) = happyGoto action_65
action_61 (8) = happyGoto action_61
action_61 _ = happyReduce_8

action_62 (18) = happyShift action_14
action_62 (21) = happyShift action_15
action_62 (22) = happyShift action_16
action_62 (23) = happyShift action_17
action_62 (27) = happyShift action_18
action_62 (11) = happyGoto action_11
action_62 (12) = happyGoto action_12
action_62 (13) = happyGoto action_64
action_62 _ = happyFail

action_63 _ = happyReduce_4

action_64 (26) = happyShift action_74
action_64 _ = happyFail

action_65 _ = happyReduce_9

action_66 (18) = happyShift action_40
action_66 (19) = happyShift action_41
action_66 (21) = happyShift action_42
action_66 (22) = happyShift action_43
action_66 (23) = happyShift action_44
action_66 (8) = happyGoto action_73
action_66 _ = happyFail

action_67 (18) = happyShift action_14
action_67 (21) = happyShift action_15
action_67 (22) = happyShift action_16
action_67 (23) = happyShift action_17
action_67 (27) = happyShift action_18
action_67 (11) = happyGoto action_72
action_67 _ = happyFail

action_68 (18) = happyShift action_40
action_68 (19) = happyShift action_41
action_68 (21) = happyShift action_42
action_68 (22) = happyShift action_43
action_68 (23) = happyShift action_44
action_68 (8) = happyGoto action_71
action_68 _ = happyFail

action_69 _ = happyReduce_11

action_70 _ = happyReduce_23

action_71 (25) = happyShift action_62
action_71 _ = happyReduce_14

action_72 _ = happyReduce_17

action_73 (25) = happyShift action_62
action_73 _ = happyReduce_13

action_74 _ = happyReduce_15

happyReduce_1 = happySpecReduce_0 4 happyReduction_1
happyReduction_1  =  HappyAbsSyn4
		 ([]
	)

happyReduce_2 = happySpecReduce_2 4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 ((happy_var_1:happy_var_2)
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happyReduce 7 5 happyReduction_3
happyReduction_3 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (PDefEntry happy_var_2 IsType happy_var_6 happy_var_4
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 7 5 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (PDefEntry happy_var_2 IsTerm happy_var_6 happy_var_4
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 5 5 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (PVarEntry happy_var_2 IsType happy_var_4
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 5 5 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (PVarEntry happy_var_2 IsTerm happy_var_4
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_2 6 happyReduction_7
happyReduction_7 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (listToTerm (happy_var_1:happy_var_2)
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_0 7 happyReduction_8
happyReduction_8  =  HappyAbsSyn7
		 ([]
	)

happyReduce_9 = happySpecReduce_2 7 happyReduction_9
happyReduction_9 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1:happy_var_2
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1 8 happyReduction_10
happyReduction_10 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn6
		 (PVar happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3 8 happyReduction_11
happyReduction_11 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_2 8 happyReduction_12
happyReduction_12 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happyReduce 4 8 happyReduction_13
happyReduction_13 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (PAbs happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 4 8 happyReduction_14
happyReduction_14 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (PTyAbs happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 4 8 happyReduction_15
happyReduction_15 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (PTyApp happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_0 9 happyReduction_16
happyReduction_16  =  HappyAbsSyn9
		 (Nothing
	)

happyReduce_17 = happySpecReduce_2 9 happyReduction_17
happyReduction_17 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Just happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_0 10 happyReduction_18
happyReduction_18  =  HappyAbsSyn9
		 (Nothing
	)

happyReduce_19 = happySpecReduce_2 10 happyReduction_19
happyReduction_19 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Just happy_var_2
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1 11 happyReduction_20
happyReduction_20 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn6
		 (PVar happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3 11 happyReduction_21
happyReduction_21 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_2 11 happyReduction_22
happyReduction_22 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happyReduce 5 11 happyReduction_23
happyReduction_23 ((HappyAbsSyn6  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (PForall happy_var_2 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 4 11 happyReduction_24
happyReduction_24 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (PAbs happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_25 = happySpecReduce_1 12 happyReduction_25
happyReduction_25 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_2 12 happyReduction_26
happyReduction_26 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (PApp happy_var_1 happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1 13 happyReduction_27
happyReduction_27 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3 13 happyReduction_28
happyReduction_28 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (PArr happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1 14 happyReduction_29
happyReduction_29 _
	 =  HappyAbsSyn6
		 (PType
	)

happyReduce_30 = happySpecReduce_3 14 happyReduction_30
happyReduction_30 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_2 14 happyReduction_31
happyReduction_31 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1 15 happyReduction_32
happyReduction_32 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3 15 happyReduction_33
happyReduction_33 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (PArr happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TokenEOF -> action 32 32 (error "reading EOF!") (HappyState action) sts stk;
	TokenType -> cont 16;
	TokenArr -> cont 17;
	TokenLambda -> cont 18;
	TokenTyLambda -> cont 19;
	TokenCol -> cont 20;
	TokenVar happy_dollar_dollar -> cont 21;
	TokenDot -> cont 22;
	TokenLParen -> cont 23;
	TokenRParen -> cont 24;
	TokenLBr -> cont 25;
	TokenRBr -> cont 26;
	TokenForall -> cont 27;
	TokenSemi -> cont 28;
	TokenIdType -> cont 29;
	TokenIdTerm -> cont 30;
	TokenDef -> cont 31;
	_ -> happyError
	})

happyThen :: P a -> (a -> P b) -> P b
happyThen = (thenP)
happyReturn :: a -> P a
happyReturn = (returnP)
happyThen1 = happyThen
happyReturn1 = happyReturn

parseDef = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq

happyError :: P a
happyError = getLineNo `thenP` \line ->
              failP ("Parse Error at line: "++ show line)

type TTPair = (PExp,PExp)

data PDef = PDefEntry String Indicator PExp PExp
          | PVarEntry String Indicator PExp

data PExp = PVar String                       
      | PAbs String (Maybe PExp) PExp         
      | PApp PExp PExp                
      | PTyAbs String (Maybe PExp) PExp                       
      | PTyApp PExp PExp                                      
      | PArr PExp PExp                
      | PType                         
      | PForall String PExp PExp
      deriving Show





listToTerm :: [PExp] -> PExp
listToTerm (e:es) = foldl PApp e es



pExpToExp :: PExp -> [String] -> Exp
pExpToExp (PVar v) vs = Var (posOf v vs)
pExpToExp (PAbs s mbe e) vs = Abs s (maybePtE mbe vs) (pExpToExp e (s:vs))
pExpToExp (PApp e1 e2) vs = App (pExpToExp e1 vs) (pExpToExp e2 vs)
pExpToExp (PTyAbs s mbe e) vs = TyAbs s (maybePtE mbe vs) (pExpToExp e (s:vs))
pExpToExp (PTyApp e1 e2) vs = TyApp (pExpToExp e1 vs) (pExpToExp e2 vs)
pExpToExp (PArr e1 e2) vs = Arr (pExpToExp e1 vs) (pExpToExp e2 vs)
pExpToExp (PType) vs = Type
pExpToExp (PForall s e1 e2) vs = Forall s (pExpToExp e1 vs) (pExpToExp e2 (s:vs))

maybePtE :: (Maybe PExp) -> [String] -> (Maybe Exp)
maybePtE Nothing vs = Nothing
maybePtE (Just e) vs = Just (pExpToExp e vs)



pDefToDef :: PDef -> [String] -> VarBin
pDefToDef (PDefEntry name ind e1 e2) vs = (name,(DefEntry ind (pExpToExp e1 vs) (pExpToExp e2 vs)))
pDefToDef (PVarEntry name ind e) vs = (name, VarEntry ind (Just (pExpToExp e vs)))



allPDefToDef :: [PDef] -> [String] -> Context
allPDefToDef [] _ = []
allPDefToDef ((PDefEntry name ind e1 e2):defs) vs =
--let name' = freeV vs name in
    (pDefToDef (PDefEntry name ind e1 e2) vs):(allPDefToDef defs (name:vs))
allPDefToDef ((PVarEntry name ind e):defs) vs = 
    (pDefToDef (PVarEntry name ind e) vs):(allPDefToDef defs (name:vs))




freeV :: [String] -> String -> String
freeV vs v = 
      if any (\s -> s==v) vs
      then freeV vs (v ++ "'")
      else v




posOf :: String -> [String] -> Int
posOf s xs = intposOf s xs 0

intposOf s [] i = error ("Variable " ++ s ++ " nicht im Kontext!")
intposOf s (x:xs) i
      | s==x = i
      | otherwise = intposOf s xs (i+1)



parseDefinitions :: String -> Error Context
parseDefinitions s =
	do	pd <- parseDef s 1
		return (allPDefToDef pd [])
{-# LINE 1 "GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.23 2002/05/23 09:24:27 simonmar Exp $

{-# LINE 15 "GenericTemplate.hs" #-}






















































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

happyAccept j tk st sts (HappyStk ans _) = 

					   (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 150 "GenericTemplate.hs" #-}


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError


{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
