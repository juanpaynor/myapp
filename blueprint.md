
# Project Blueprint

## Overview

This document outlines the project structure, design, and features of the Bitemates Flutter application. The app aims to connect people through shared dining experiences, and this blueprint details its functionality from user onboarding to core features.

## Current State

### Style, Design, and Features

*   **Theming:** The application uses a modern Material 3 theme with a custom color scheme derived from a seed color, and custom typography using the `google_fonts` package.
*   **Routing:** Navigation is handled by the `go_router` package, with protected routes and automatic redirection based on the user's authentication state.
*   **Authentication:**
    *   **Auth Service:** A dedicated `AuthService` (`lib/auth_service.dart`) handles all authentication logic, including Google Sign-In, email/password sign-up, login, and logout.
    *   **Login Page:** A full-featured login page (`lib/login_page.dart`) with options for email/password and Google Sign-In. It includes a "Remember Me" checkbox to control session persistence (`Persistence.LOCAL` vs. `Persistence.SESSION`).
    *   **Sign-Up Flow:** A multi-step sign-up process allows users to register with Google or a standard email and password.
    *   **Session Management:** The router listens to authentication state changes and automatically redirects users, protecting private routes and ensuring a seamless user experience.
*   **Home Page:** A basic home page (`lib/home_page.dart`) with a logout button in the `AppBar`.

## Previous Request: Implement a Social Sign-Up Flow

### Plan

1.  **Create New Pages:**
    *   `lib/signup_page.dart`: A central screen offering two sign-up options: "Sign up with Google" and "Create account".
    *   `lib/regular_signup_page.dart`: A form for users to manually enter their Full Name, Email, Password, and Age.
    *   `lib/personality_test_page.dart`: A mandatory, interactive quiz to determine the user's "dining personality."
    *   `lib/personality_summary_page.dart`: A screen to display a summary of the user's personality type, a profile preview, and suggested next steps.

2.  **Update Routing:**
    *   Integrate the new pages into the `GoRouter` configuration in `main.dart` with the following paths: `/signup`, `/regular-signup`, `/personality-test`, `/summary`.

3.  **Modify Login Page:**
    *   Update the "Sign Up" button on `lib/login_page.dart` to navigate to the new `/signup` route.

4.  **Implement UI and Logic:**
    *   **Design:** All new screens will feature playful, vibrant visuals with food-themed illustrations/icons and an intuitive, interactive user experience.
    *   **Google Sign-Up:** The "Sign up with Google" button will be designed to (conceptually) trigger authentication and then navigate directly to the `/personality-test` page.
    *   **Regular Sign-Up:** The form will validate user input and, upon submission, navigate to the `/personality-test` page.
    *   **Personality Test:** This page will present a series of fun, food-related questions. User data (name, age) will be passed to this page.
    *   **Summary Page:** After completing the test, users will be taken to a summary page that displays their generated "Bitemate Personality" on a visually appealing card, along with a profile preview and clear calls-to-action like "Discover Events" or "Invite Friends."
