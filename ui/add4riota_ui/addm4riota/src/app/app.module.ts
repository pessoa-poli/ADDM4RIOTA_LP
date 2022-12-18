import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { StarterComponent } from './components/starter/starter.component';
import { SideBarComponent } from './components/side-bar/side-bar.component'; 
import { MaterialModule } from './material/material/material.module';

@NgModule({
  declarations: [
    AppComponent,
    StarterComponent,
    SideBarComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
