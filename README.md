# 🐻 Flutter Bear Login App

A Flutter login interface featuring an interactive Rive animation.  
The main character (a little bear) follows the user’s typing with its eyes,
covers them for the password field and reacts to success/failure events.

---
## Table 
---

## 📝 Description

Sample application for the **Computer Graphics** course.  
It demonstrates how to integrate vector animations and state machines in a
Flutter app to enhance the user experience.

---

## 🚀 Features

- **Bear animation**  
  The bear changes its gaze according to the input:

  - Looks at the email field when it has focus.
  - Raises its hands and follows the text length when the password field is
    active.
  - Triggers success/failure transitions when the form is validated.

- **Dynamic focus sensing** using `FocusNode` on each `TextField`.

- **State machine inputs** (`isChecking`, `isHandsUp`, `trigSuccess`,
  `trigFail`) to drive smooth transitions.

> All the behaviour is achieved with very little code thanks to the
> collaboration between Flutter and Rive.

---

## 🎨 Rive & State Machines

Rive is a vector animation tool that lets you design characters, effects and
export them to a `.riv` file. Runtime libraries (Flutter, Web, etc.) play the
animation in real time.

A `.riv` file can contain **State Machines**, which encapsulate the animation
logic. They expose inputs of types:

- `boolean`  
- `number`  
- `trigger`

In this project the bear’s State Machine uses the inputs mentioned above.
Flutter’s `FocusNode`s update those inputs on the fly, making the bear:

1. Turn its head towards the active field.
2. Raise its hands when typing a password.
3. Show success/error gestures after pressing “Login”.

---

## 🛠️ Technologies

- **Flutter** – cross‑platform UI framework (Android, iOS, Web, Windows…).
- **Dart** – the language used by Flutter.
- **Rive** – vector animation engine/editor.
- Pub packages such as `rive` (and others you include: `provider`, `http`, …).

---

## 📂 Project structure

lib/
├── main.dart # entry point
├── app.dart # root widget with MaterialApp
├── screens/
│ └── login_page.dart # form + focus logic
│ └── home_page.dart # example second screen
├── widgets/
│ └── bear_animation.dart # widget wrapping the Rive Actor
├── models/ # data classes
├── providers/ # state management
└── services/ # APIs, storage, etc.
assets/
└── bear.riv # bear animation


---

## 🎬 Demo

Below is the full behaviour of the application:

![Login with animated bear](/flutter_application_1/assets/Flutter-Demo-Google-Chrome-2026-02-21-14-02-56.gif)

> The GIF shows the bear tracking the email field, covering his eyes for the
> password field and reacting to valid/invalid login attempts.

---

## 📚 Subject

**Computer Graphics**

---

## 👨‍🏫 Instructor

Rodrigo Fidel Gaxiola Sosa

---

## 🤝 Acknowledgments

Original animation by **Dexter: Login Machine Remix**

---
