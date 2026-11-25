import { LightningElement } from 'lwc';

export default class IteratorLoopexample extends LightningElement {

    flag = false;

    employeeList = [
        {
            FirstName: 'Yadu Krishna',
            LastName: 'TP',
            Email: 'yadu@gmail.com',
            Phone: '8921580819',
            Age: 26,
            Rank: 1

        },
        {
            FirstName: 'Sreeshma',
            LastName: 'TS',
            Email: 'sreeshma@gmail.com',
            Phone: '9874589668',
            Age: 26,
            Rank: 2
        },
        {
            FirstName: 'Sreejith',
            LastName: 'TP',
            Email: 'sreejith@gmail.com',
            Phone: '9045866558',
            Age: 29,
            Rank: 3
        }

    ]

    checkFlag(event) {
        this.flag = event.target.checked;
    }
}