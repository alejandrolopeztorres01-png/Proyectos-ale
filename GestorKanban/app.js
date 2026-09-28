/**
 * =========================================================================
 * GESTOR KANBAN - LÓGICA DE NEGOCIO (Vanilla JS)
 * Desarrollado por: Alejandro López Torres
 * Descripción: Gestión del DOM, API Drag & Drop HTML5 y LocalStorage.
 * =========================================================================
 */

// 1. ESTADO DE LA APLICACIÓN
let tasks = JSON.parse(localStorage.getItem('kanbanTasks')) || [];

// 2. SELECCIÓN DE ELEMENTOS DEL DOM
const modal = document.getElementById('task-modal');
const btnAddTask = document.getElementById('btn-add-task');
const btnCancel = document.getElementById('btn-cancel');
const taskForm = document.getElementById('task-form');

// 3. LISTENERS DE EVENTOS (Interacción del usuario)
btnAddTask.addEventListener('click', () => {
    modal.showModal();
});

btnCancel.addEventListener('click', () => {
    modal.close();
    taskForm.reset();
});

taskForm.addEventListener('submit', (e) => {
    e.preventDefault(); 
    
    const title = document.getElementById('task-title').value.trim();
    const desc = document.getElementById('task-desc').value.trim();
    const priority = document.getElementById('task-priority').value;

    if (title !== "") {
        createNewTask(title, desc, priority);
        modal.close();
        taskForm.reset();
    }
});

// 4. FUNCIONES CORE
function createNewTask(title, desc, priority) {
    const newTask = {
        id: 'task-' + Date.now(),
        title: title,
        desc: desc,
        priority: priority,
        status: 'todo'
    };
    tasks.push(newTask);
    saveAndRender();
}

function deleteTask(id) {
    tasks = tasks.filter(task => task.id !== id);
    saveAndRender();
}

// 5. RENDERIZADO DEL DOM
function saveAndRender() {
    localStorage.setItem('kanbanTasks', JSON.stringify(tasks));

    document.getElementById('list-todo').innerHTML = '';
    document.getElementById('list-doing').innerHTML = '';
    document.getElementById('list-done').innerHTML = '';

    let countTodo = 0, countDoing = 0, countDone = 0;

    tasks.forEach(task => {
        const taskElement = document.createElement('article');
        taskElement.classList.add('task-card');
        taskElement.setAttribute('draggable', 'true');
        taskElement.setAttribute('ondragstart', `drag(event, '${task.id}')`);
        taskElement.id = task.id;

        // Estructura minimalista
        taskElement.innerHTML = `
            <h4 class="task-title">${task.title}</h4>
            ${task.desc ? `<p class="task-desc">${task.desc}</p>` : ''}
            <div class="task-footer">
                <span class="priority-badge priority-${task.priority}">
                    ${task.priority === 'high' ? 'Alta' : task.priority === 'medium' ? 'Media' : 'Baja'}
                </span>
                <button class="btn-delete" onclick="deleteTask('${task.id}')">Borrar</button>
            </div>
        `;

        document.getElementById(`list-${task.status}`).appendChild(taskElement);
        
        if(task.status === 'todo') countTodo++;
        if(task.status === 'doing') countDoing++;
        if(task.status === 'done') countDone++;
    });

    document.getElementById('count-todo').textContent = countTodo;
    document.getElementById('count-doing').textContent = countDoing;
    document.getElementById('count-done').textContent = countDone;
}

// 6. DRAG & DROP API NATIVA
function drag(event, taskId) {
    event.dataTransfer.setData("text/plain", taskId);
}

function allowDrop(event) {
    event.preventDefault(); // Permite soltar el elemento
}

function drop(event) {
    event.preventDefault();
    const taskId = event.dataTransfer.getData("text/plain");
    
    // Busca la columna donde se ha soltado (closest busca hacia arriba en el DOM)
    const dropZone = event.target.closest('.kanban-column');
    
    if (dropZone) {
        const newStatus = dropZone.getAttribute('data-status');
        const taskIndex = tasks.findIndex(t => t.id === taskId);
        
        if (taskIndex > -1 && tasks[taskIndex].status !== newStatus) {
            tasks[taskIndex].status = newStatus;
            saveAndRender();
        }
    }
}

// 7. INICIALIZACIÓN
saveAndRender();