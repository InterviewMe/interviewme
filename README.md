# *InterviewMe*

**InterviewMe** is a platform where users can share interview experiences and questions.

## User Stories

The following **8** functionalities have been completed:

- [x] User can post an interview request
- [x] User is taken to a home feed viewcontroller
- [x] User can comment on other user's post
- [x] User can customize a profile
- [x] User can access Settings screenaccess
- [x] User can login/signup for account

The following **stretch** features are implemented:

- [x] User login is persisted across restarts
- [x] Style individual view controllers


Database Schema:

table: User
columns: _id, email, username, last_name, first_name, hashed_password, bio, job_title, profile_url, school, major

table: Post
columns: _id, User, text, date, reply_count, reply_array



## Video Walkthrough

Here's a walkthrough of implemented user stories:

![InterviewMe Video Walkthrough](https://github.com/InterviewMe/interviewme/blob/master/interviewme6.gif)

-GIF created with [LiceCap](http://www.cockos.com/licecap/).


## License

Copyright 2018 InterviewMe: Tianyu Liang, Somi Singh, Henry Vuong

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

