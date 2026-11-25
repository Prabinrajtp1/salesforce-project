import { LightningElement, wire } from 'lwc';
import getMovieDetails from '@salesforce/apex/IMBDController.getMovieDetails';

export default class MoviesList extends LightningElement {

    enteredText = '';
    searchText = '';
    showText = 'Please Enter Valid Movie Name';
    movies = [];

    handleChange(event) {
        this.enteredText = event.target.value;

    }

    handleClick(event) {
        this.searchText = this.enteredText;

    }

    @wire(getMovieDetails, { searchName: '$searchText' })
    movieDetails(result) {

        if (result.data) {
            let data = JSON.parse(result.data);
            if (data.success) {
                this.movies = data.result;
                this.showText = '';
            }
            else {
                this.movies = [];
                this.showText = 'Please Enter Valid Movie Name';

            }
        }
        else if (result.error) {
            console.log('Error occured While searching Movies:' + result.error);
            this.showText = 'Error occured While searching Movies:' + result.error;
        }
    }
}