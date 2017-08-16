import { Component, OnInit, Input } from '@angular/core';
import { ModalService } from "../../../services/modal.service";
import { Team } from "../../../domain/team";
import { FormGroup, FormBuilder, Validators } from "@angular/forms";
import { Router } from "@angular/router";
import { TeamService } from "../../../services/team.service";
import * as Globals from '../../../globals';


@Component({
  selector: 'app-edit-team',
  templateUrl: './edit-team.component.html'
})
export class EditTeamComponent implements OnInit {

  team: Team;

  editTeamFormGroup: FormGroup;
  nameValue : string = '';
  descriptionValue: string = '';

  constructor(private fb: FormBuilder,
              private teamService: TeamService,
              private router: Router,
              public modalService: ModalService) { }

  ngOnInit() {
    this.teamService.teamChange.subscribe(result => {
      this.team = result;
      this.nameValue = this.team.name;
      this.descriptionValue = this.team.description;
    });


    this.editTeamFormGroup = this.fb.group({
      'name': ['', Validators.required],
      'description': ['', Validators.required]
    });
  }

  editProject(values){
    console.log(this.team.id);
    console.log(values.name);
    this.teamService.editTeam(this.team.id, values.name, values.description);
    this.modalService.closeModal();
  }

  deleteProject() {
    this.teamService.deleteTeam(this.team.id);
    this.modalService.closeModal();
    this.router.navigate(['/projects']);
  }
}
