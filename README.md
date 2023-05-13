<h1 align="center"> SeamLabs Interview Challenge </h1>

## Note that:

- Start your review from solution steps section because the first and the second I wrote it from the task documentation but I wrote it here to document this work for myself.
- Check task [jira project](https://iostask.atlassian.net/jira/software/projects/NEW/boards/2/backlog).
- Chech each commit messege.
- Don't forget to send me your feedback I really want this feedback.

# Table of Content
- [About Task](#about-task)
- [Requirements](#requirements)
- [Solution Steps](#solution-steps)


# About Task
  ### OverView
  Implement news App that shows apple news using [News API](https://newsapi.org).
  
# Requirements
1. The user should be able to locate a list of news headlines with their main thumbnail. When
clicked, the user should be able to view the whole article.

2. User should be able to rate the news, at the end of the whole article screen with a textfield
and save button (rate should be from 1- 5), if the input is valid show alert to the user that you
have successfully rated the article.(No need to save the rate)

3. The user should be able to use the app offline and see the last loaded data.

# Solution Steps
### Code Linting
I used code linting in this task, this what I made:
- Naming: used [camel Case style](https://en.wikipedia.org/wiki/Camel_case).
    - Functions Naming: should start with verb that explain it's role. 
    - Functions Body: should be 9 or 15 lines if it exceed should split the code to 2 functions.
- Patterns: [MVVM](https://www.geeksforgeeks.org/mvvm-model-view-viewmodel-architecture-pattern-in-android/) and [Singletone](https://refactoring.guru/design-patterns/singleton).
- Software Development Methodologies: Agile Methodologies (SRUM Methodology)
- Each file has sections made by "MARK:" comment each section contains the data for it's role.
- Each file related with UI contains a function named "updateUi()" this function responsible for any thing related with UI and beside it there's many support functions that support it to achieve its role.
- Version Control: Github.
    - Each commit message in this task repo contains two parts.
        - the first is Jira Task story ID.
        - the second is name of the task.

### Agile Methodology
They said that "Success comes from good planning" and after reading and understanding it, I decided to plan well for solve the task here's my solution steps in detail:
1. I used Jira Software for this task you can check the project [NewsApp](https://iostask.atlassian.net/jira/software/projects/NEW/boards/2/backlog) in this task I Choosed [SRUM Methodology](https://www.infoworld.com/article/3237508/what-is-agile-methodology-modern-software-development-explained.html#:~:text=developers%20without%20micromanaging%20%5D-,Scrum%20and%20kanban,-Once%20a%20product)
2. Divide the project to stories tasks.
3. create project Backlog Stories and set estimated time and assign it to team member.
4. create sprint from one or more story.
6. Complete each sprint successfully.

### Finally Start writing code with strait and clean way.

##  
<h2 align="center"> Thank you for this awesome task and I will do my best to be join Seam Labs to learn alote from you. Thanks again</h2>
