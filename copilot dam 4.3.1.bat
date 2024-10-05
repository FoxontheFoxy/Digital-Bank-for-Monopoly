@echo off
setlocal enabledelayedexpansion

echo Coded by Microsoft Copilot
echo Prompted by FoxontheFoxy
echo Version Offline 4.3.1
pause 

:: Initialize player data
set /p player1_name=Player 1 Name:
set player1_balance=1500
set player1_position=0
set player1_in_jail=0
set /p player2_name=Player 2 Name:
set player2_balance=1500
set player2_position=0
set player2_in_jail=0
set /p player3_name=Player 3 Name:
set player3_balance=1500
set player3_position=0
set player3_in_jail=0
set /p player4_name=Player 4 Name:
set player4_balance=1500
set player4_position=0
set player4_in_jail=0

set turn=1
set board_size=40

goto menu

:get_position_name
if "%1"=="0" set pos_name=Go
if "%1"=="1" set pos_name=Mediterranean Avenue
if "%1"=="2" set pos_name=Community Chest
if "%1"=="3" set pos_name=Baltic Avenue
if "%1"=="4" set pos_name=Income Tax
if "%1"=="5" set pos_name=Reading Railroad
if "%1"=="6" set pos_name=Oriental Avenue
if "%1"=="7" set pos_name=Chance
if "%1"=="8" set pos_name=Vermont Avenue
if "%1"=="9" set pos_name=Connecticut Avenue
if "%1"=="10" set pos_name=Jail / Just Visiting
if "%1"=="11" set pos_name=St. Charles Place
if "%1"=="12" set pos_name=Electric Company
if "%1"=="13" set pos_name=States Avenue
if "%1"=="14" set pos_name=Virginia Avenue
if "%1"=="15" set pos_name=Pennsylvania Railroad
if "%1"=="16" set pos_name=St. James Place
if "%1"=="17" set pos_name=Community Chest
if "%1"=="18" set pos_name=Tennessee Avenue
if "%1"=="19" set pos_name=New York Avenue
if "%1"=="20" set pos_name=Free Parking
if "%1"=="21" set pos_name=Kentucky Avenue
if "%1"=="22" set pos_name=Chance
if "%1"=="23" set pos_name=Indiana Avenue
if "%1"=="24" set pos_name=Illinois Avenue
if "%1"=="25" set pos_name=B. & O. Railroad
if "%1"=="26" set pos_name=Atlantic Avenue
if "%1"=="27" set pos_name=Ventnor Avenue
if "%1"=="28" set pos_name=Water Works
if "%1"=="29" set pos_name=Marvin Gardens
if "%1"=="30" set pos_name=Go to Jail
if "%1"=="31" set pos_name=Pacific Avenue
if "%1"=="32" set pos_name=North Carolina Avenue
if "%1"=="33" set pos_name=Community Chest
if "%1"=="34" set pos_name=Pennsylvania Avenue
if "%1"=="35" set pos_name=Short Line
if "%1"=="36" set pos_name=Chance
if "%1"=="37" set pos_name=Park Place
if "%1"=="38" set pos_name=Luxury Tax
if "%1"=="39" set pos_name=Boardwalk
goto :eof

:menu
cls
echo.
echo Player Balances
echo ===============
for /l %%i in (1,1,4) do (
    echo !player%%i_name!: !player%%i_balance!
)
echo.
echo Player Positions
echo =================
for /l %%i in (1,1,4) do (
    if !player%%i_in_jail!==1 (
        echo !player%%i_name! is in Jail
    ) else (
        set pos=!player%%i_position!
        call :get_position_name !pos!
        echo !player%%i_name! is at position !pos! = !pos_name!
    )
)
echo.
echo Monopoly Banking System
echo ========================
echo 1. Add/Deduct All Players' Money
echo 2. Add/Deduct Individual Player's Money
echo 3. Show Balances of All Players
echo 4. Set Player's Name
echo 5. Next Turn
echo 6. Show Player Positions
echo 7. Enter Dice Result and Move
echo 8. Send Active Player to Jail
echo 9. Release Active Player from Jail
echo 10. Transfer Money (1 to 1)
echo 11. Transfer Money (All to Active)
echo 12. Transfer Money (Active to All)
echo 13. Exit
echo.
echo Current Turn: !player%turn%_name!
set /p choice=Choose an option:

if %choice%==1 goto add_deduct_all
if %choice%==2 goto add_deduct_individual
if %choice%==3 goto show_balances
if %choice%==4 goto set_name
if %choice%==5 goto next_turn
if %choice%==6 goto show_positions
if %choice%==7 goto enter_dice
if %choice%==8 goto send_to_jail
if %choice%==9 goto release_from_jail
if %choice%==10 goto transfer_one_to_one
if %choice%==11 goto transfer_all_to_active
if %choice%==12 goto transfer_active_to_all
if %choice%==13 exit

:add_deduct_all
set /p amount=Enter amount to add/deduct (use negative for deduction):
for /l %%i in (1,1,4) do (
    set /a player%%i_balance+=amount
)
goto menu

:add_deduct_individual
set /p player=Enter player number (1-4):
set /p amount=Enter amount to add/deduct (use negative for deduction):
set /a player%player%_balance+=amount
goto menu

:show_balances
cls
echo Player Balances
echo ===============
for /l %%i in (1,1,4) do (
    echo !player%%i_name!: !player%%i_balance!
)
pause
goto menu

:set_name
set /p player=Enter player number (1-4):
set /p name=Enter new name:
set player%player%_name=%name%
goto menu

:next_turn
set /a turn+=1
if %turn% gtr 4 set turn=1
goto menu

:show_positions
cls
echo Player Positions
echo =================
for /l %%i in (1,1,4) do (
    if !player%%i_in_jail!==1 (
        echo !player%%i_name! is in Jail
    ) else (
        set pos=!player%%i_position!
        call :get_position_name !pos!
        echo !player%%i_name! is at position !pos! = !pos_name!
    )
)
pause
goto menu

:enter_dice
set /p dice_total=Enter the total dice result:
if !player%turn%_in_jail!==1 (
    echo !player%turn%_name! is in Jail and cannot move.
) else (
    set /a player%turn%_position+=dice_total
    if !player%turn%_position! geq %board_size% (
        set /a player%turn%_position-=board_size
        echo !player%turn%_name! passed GO and collects $200!
        set /a player%turn%_balance+=200
    )
)
goto menu

:send_to_jail
set player%turn%_in_jail=1
set player%turn%_position=10
echo !player%turn%_name! has been sent to Jail!
pause
goto menu

:release_from_jail
set player%turn%_in_jail=0
echo !player%turn%_name! has been released from Jail!
pause
goto menu

:transfer_one_to_one
set /p recipient=Enter recipient player number (1-4):
set /p amount=Enter amount to transfer:
set /a player%turn%_balance-=amount
set /a player%recipient%_balance+=amount
goto menu

:transfer_all_to_active
set /p amount=Enter amount to transfer from all players to active player:
for /l %%i in (1,1,4) do (
    if %%i neq %turn% (
        set /a player%%i_balance-=amount
        set /a player%turn%_balance+=amount
    )
)
goto menu

:transfer_active_to_all
set /p amount=Enter amount to transfer from active player to all players:
for /l %%i in (1,1,4) do (
    if %%i neq %turn% (
        set /a player%%i_balance+=amount
        set /a player%turn%_balance-=amount
    )
)
goto menu
