//add top scores to text files
// highlight in green if word is being typed correctly
//ask difference between arraylist and string[]

String[] words;
ArrayList<String> scores = new ArrayList();
String currentMessage, welcomeMessage, message, messageInput, gameOver;
String playerName, inputName;
float score, wpm, timer, finalwpm;
int startTime;
boolean playing;
boolean rightWord;



void setup()
{
  size(1100, 605);
  noStroke();
  playing = true; // sets the game on or off
  //scores = loadStrings("scoreboard.txt"); // loads scoreboard text file
  score = 0; // score starts at 0
  startTime = -1; // avoids wpm being infinity
  wpm = 0;
  gameOver = "GAME OVER";
  playerName = "";
  messageInput = "";
  inputName = "welcome, please type your name";
  welcomeMessage = "welcome" + " playerName" + " type start to play";
  PFont font; // CREATES THE FONT FOR THE GAME, USING CMD STYLE
  font = createFont("Consolas", 48); // CREATES THE FONT FOR THE GAME, USING CMD STYLE
  textFont(font); // CREATES THE FONT FOR THE GAME, USING CMD STYLE
  words = loadStrings("words_alpha.txt"); // LOADS WORDS TEXT FILE
  message = inputName;
  currentMessage = inputName;
}



void draw()
{
  //println(messageInput.length());
  //println(currentMessage.substring(0,messageInput.length()));
  if(messageInput.length()<=currentMessage.length())
  {
  if ((messageInput.length()>=1)   &&   messageInput.equals(currentMessage.substring(0, messageInput.length()))) { // if messageinput length is greater than current message it crashes.
    rightWord = true;

    currentMessage.substring(messageInput.length()-1);
  } else
  {
    rightWord = false;
  }
  }
  if (playing)
  {
    timer = 60.0 - (millis() - startTime)/1000;
    wpm = score/((millis()-startTime)/60000.0);
    //if(currentMessage.substring(messageInput.length()).equals(messageInput))
  }
  background(#0C0C0C);
  if (rightWord)
  {
    fill(0, 255, 0);
  } else
  {
    if(playing)
    {
    fill(255);
    }
    else
    {
    fill(255,0,0);
    }
  }
  text(messageInput, width/5, height*0.8); // PLAYER WRITTEN TEXT (INPUT BY PLAYER)
  text(currentMessage, 50, height/2); // GUI TEXT (SYSTEM INPUT)
  if (messageInput.equals(currentMessage)) // IF PLAYER TYPES THE WORD CORRECTLY, RESETS INPUT, GENERATES NEW WORD AND ADDS 1 TO THE SCORE
  {
    messageInput = "";
    currentMessage = words[int(random(words.length))];
    text(currentMessage, 50, height/2);
    score = score + 1;
  }
  if (startTime > 0) // ONCE GAME HAS STARTED, SHOWS WPM, SCORE AND TIME LEFT
  { if(playing)
    {
    fill(255);
    }
    else
    {
    fill(255,0,0);
    }
    text("wpm: " + nf(wpm, 0, 1), 800, 100);
    text("words: " + nf(score, 1, 0), 800, 150);
    text("time left: " + nf(timer, 0, 0), 700, 200);
  }
  if (timer <= 0) // IF TIMER REACHES 0, ENDS THE GAME AND SHOWS GAME OVER MESSAGE
  {
    playing = false;
    currentMessage = gameOver;
  }
  if (playing == false) // STORES FINAL WPM AND SCORE AND SAVES IT TO THE TOP SCORERS TEXT FILE
  {
    stroke(10);
    fill(255, 0, 0);
    finalwpm = wpm;
    scores.add(playerName + ": " + finalwpm);
  }
  //println(int(wpm));
}


void keyPressed()
{
  if (playing)
  {  
    if (((key>= 'a' && key<='z')||(key>= 'A' && key<='Z'))) // ENABLES TEXT INPUT BY PLAYER
    {
      messageInput = messageInput + key;
    }
    if ((key == BACKSPACE && messageInput.length()>0))// ENABLES DELETING TEXT USING BACKSPACE
    {
      messageInput = messageInput.substring(0, messageInput.length()-1);
      //println("j");
    }
    if ((key == ENTER)&& currentMessage.equals( inputName )) //IF 'ENTER' IS PRESSED, SAVES PLAYER NAME WHEN MESSAGE IS 'inputName'
    {
      playerName = messageInput.toUpperCase();
      messageInput = "";
      currentMessage =   welcomeMessage = "welcome " +  playerName + ", type start to play";
    }
    if (messageInput.equals("start") && currentMessage.equals(welcomeMessage)) // IF "start" IS TYPED, STARTS THE GAME
    {
      currentMessage = words[int(random(words.length))];
      messageInput = "";
      startTime = millis() ;
    }
  }
}
