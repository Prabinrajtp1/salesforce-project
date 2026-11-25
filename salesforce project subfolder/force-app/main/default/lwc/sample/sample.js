import { LightningElement } from 'lwc';

export default class Sample extends LightningElement {
    flag = false;
    employees = [
        {
            FirstName: 'Prabinraj',
            LastName: 'TP',
            Email: 'rajprabin321@gmail.com',
            Phone: '9605790030',
            Age: 29,
            Rank: 1
        },
        {
            FirstName: 'Yadu Krishna',
            LastName: 'TP',
            Email: 'yadu@gmail.com',
            Phone: '8921580819',
            Age: 26,
            Rank: 2
        }

    ]

    get getemployeeRank() {
        const rank = this.employee.Age >= 50 ? '3' : this.employee.Age >= 30 ? '2' : '1';
        return rank;
    }
    statusChanged(event) {
        this.flag = event.target.checked;
    }

}