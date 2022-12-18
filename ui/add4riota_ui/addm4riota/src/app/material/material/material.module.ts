import { NgModule } from '@angular/core';

import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import {MatToolbarModule} from '@angular/material/toolbar'; 
import {MatSidenavModule} from '@angular/material/sidenav';

const material = [
  MatSlideToggleModule,
  MatToolbarModule,
  MatSidenavModule,
];
@NgModule({
  imports: [material],
  exports: [material]
})
export class MaterialModule { }
